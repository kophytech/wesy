import 'dart:async';
import 'dart:convert';

import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:cs_storage/cs_storage.dart';

//Exception thrown when user login fails
class LoginRequestFailure implements Exception {
  const LoginRequestFailure({this.message});
  final String? message;

  @override
  String toString() {
    return message ?? '';
  }
}

//Exception thrown when user unknown error occur
class LoginFailure implements Exception {}

//Exception thrown when user login fails
class ChangePasswordRequestFailure implements Exception {
  const ChangePasswordRequestFailure({this.message});
  final String? message;

  @override
  String toString() {
    return message ?? '';
  }
}

//Exception thrown when user unknown error occur
class ChangePasswordFailure implements Exception {}

enum AuthStatus {
  unknown,
  intial,
  authenticated,
  unauthenticated,
}

class AuthRepository {
  AuthRepository({
    AuthApiClient? authApiClient,
    CsStorage? csStorage,
  })  : _authApiClient = authApiClient ?? AuthApiClient(),
        _csStorage = csStorage ?? CsStorage();

  final AuthApiClient _authApiClient;
  final CsStorage _csStorage;
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    final hasUser = await _csStorage.check('user');
    final hasToken = await _csStorage.check('token');
    // final isOnboardingCompleted = _siaraStorage.read('onboarding_completed');
    if (hasUser && hasToken) {
      yield AuthStatus.authenticated;
    } else if (!hasUser && !hasToken) {
      yield AuthStatus.unauthenticated;
    } else {
      yield AuthStatus.unknown;
    }
    // yield* _controller.stream;
  }

  Future<User> get user async {
    final jsonData = jsonDecode(await _csStorage.readString('user') ?? '');
    return User.fromJson(jsonData);
  }

  Future<User> login({
    required String? email,
    required String? password,
  }) async {
    try {
      final response =
          await _authApiClient.login(email: email, password: password);
      _csStorage.saveString(key: 'token', value: response['data']['token']);
      _csStorage.saveString(
          key: 'tokenExpiresOn', value: response['data']['tokenExpiresOn']);
      _csStorage.saveString(
          key: 'user', value: jsonEncode(response['data']['user']));
      _controller.add(AuthStatus.authenticated);
      return User.fromJson(response['data']['user']);
    } on HttpRequestFailure catch (e) {
      throw LoginRequestFailure(message: e.toString());
    } on HttpError {
      throw LoginFailure();
    }
  }

  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _authApiClient.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return response['message'];
    } on HttpRequestFailure catch (e) {
      throw ChangePasswordRequestFailure(message: e.toString());
    } on HttpError {
      throw ChangePasswordFailure();
    }
  }

  Future<User> getUserData() async {
    try {
      final response = await _authApiClient.getUserProfile();
      return User.fromJson(response['data']);
    } on HttpRequestFailure catch (e) {
      throw ChangePasswordRequestFailure(message: e.toString());
    } on HttpError {
      throw ChangePasswordFailure();
    }
  }

  // Future<User> get user async {
  //   final response = await _csStorage.readString('user');
  //   final user = jsonDecode(response!);
  //   return User(
  //     email: user['email'],
  //     name: user['name'],
  //     phone: user['phone'].toString(),
  //   );
  // }

  Future<void> logOut() async {
    await _csStorage.remove('user');
    await _csStorage.remove('token');
    await _csStorage.clear();
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
