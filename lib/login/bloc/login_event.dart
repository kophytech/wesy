part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginEvent {
  const LoginInitial({this.formKey});

  final GlobalKey<FormState>? formKey;

  @override
  List<Object> get props => [formKey!];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged({this.email});

  final String? email;

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged({this.password});

  final String? password;

  @override
  List<Object?> get props => [password];
}

class ObsecureChanged extends LoginEvent {
  const ObsecureChanged({required this.value});

  final bool? value;

  @override
  List<Object?> get props => [value];
}
