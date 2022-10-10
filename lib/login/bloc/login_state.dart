part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  failure,
  success,
}

class LoginState extends Equatable {
  const LoginState({
    this.formKey,
    this.email = '',
    this.errorMessage = '',
    this.password = '',
    this.passwordObsecure = true,
    this.status = LoginStatus.initial,
    this.user = const User(),
  });

  LoginState copyWith({
    GlobalKey<FormState>? formKey,
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    bool? passwordObsecure,
    User? user,
  }) {
    return LoginState(
      formKey: formKey ?? this.formKey,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      passwordObsecure: passwordObsecure ?? this.passwordObsecure,
      user: user ?? this.user,
    );
  }

  final String email;
  final String password;
  final bool passwordObsecure;
  final LoginStatus status;
  final GlobalKey<FormState>? formKey;
  final String errorMessage;
  final User user;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
        passwordObsecure,
        formKey,
        user,
      ];
}
