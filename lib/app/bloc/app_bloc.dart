import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AppState()) {
    on<AppStatusChanged>(_onStatusChanged);
    _userSubscription = _authRepository.status.listen(
      (status) => add(AppStatusChanged(status: status)),
    );
    on<AppUserUpdated>(_onAppUserUpdated);
    on<AppGetCurrentLocation>(_onGetCurrentLocation);
    on<AppFCMToken>(_onGetAppFCMToken);
    on<SetLocale>(_onSetLocale);
  }
  final AuthRepository _authRepository;
  late final StreamSubscription<AuthStatus> _userSubscription;
  loc.Location location = loc.Location();
  Position? position;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> _onStatusChanged(
    AppStatusChanged event,
    Emitter<AppState> emit,
  ) async {
    if (event.status == AuthStatus.authenticated) {
      final user = await _authRepository.user;
      emit(state.copyWith(status: event.status, user: user));
    } else {
      emit(state.copyWith(status: event.status));
    }
  }

  Future<void> _onSetLocale(
    SetLocale event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(currentLocale: event.locale));
  }

  Future<void> _onGetAppFCMToken(
    AppFCMToken event,
    Emitter<AppState> emit,
  ) async {
    final settings = await firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await firebaseMessaging.getToken();
      emit(state.copyWith(deviceToken: token));
    }
    // emit(state.copyWith(status: event.status));
  }

  Future<void> _onAppUserUpdated(
    AppUserUpdated event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(user: event.user));
  }

  Future<bool> isPermissionGranted() async {
    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return false;
      }
      return true;
    }
    return true;
  }

  Future<bool> isServiceEnable() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      return _serviceEnabled;
    }
    return _serviceEnabled;
  }

  Future<void> _onGetCurrentLocation(
    AppGetCurrentLocation event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(state.copyWith(currentLocation: const LatLng(0, 0)));
      if (await isPermissionGranted() && await isServiceEnable()) {
        position = await Geolocator.getCurrentPosition();
        final latLng = LatLng(position!.latitude, position!.longitude);
        emit(state.copyWith(currentLocation: latLng));
      }
    } on TimeoutException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _onGetCurrentLocation(
  //   AppGetCurrentLocation event,
  //   Emitter<AppState> emit,
  // ) async {
  //   final _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     final hasRequest = await location.requestService();
  //     if (!hasRequest) {
  //       print('permission denied');
  //     }
  //   }

  //   var _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       print('permission denied');
  //     }
  //   }

  //   final _locationData = await location.getLocation();
  //   final latLng =
  //       LatLng(_locationData.latitude ?? 0, _locationData.longitude ?? 0);
  //   emit(state.copyWith(currentLocation: latLng));
  // }

  void logout() {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
