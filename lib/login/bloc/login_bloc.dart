import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const LoginState()) {
    on<LoginInitial>(_initialEvent);
    on<LoginSubmitted>(_loginSubmitted);
    on<LoginEmailChanged>(_emailChanged);
    on<LoginPasswordChanged>(_passwordChanged);
    on<ObsecureChanged>(_onObsecureChanged);
  }

  final AuthRepository _authRepository;

  void _initialEvent(
    LoginInitial event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(formKey: event.formKey));
  }

  void _onObsecureChanged(
    ObsecureChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        passwordObsecure: event.value,
        status: LoginStatus.initial,
      ),
    );
  }

  void _emailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: event.email, status: LoginStatus.initial));
  }

  void _passwordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password, status: LoginStatus.initial));
  }

  Future<void> _loginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      if (!state.formKey!.currentState!.validate()) return;
      emit(state.copyWith(status: LoginStatus.loading));
      final response = await _authRepository.login(
        email: state.email,
        password: state.password,
      );
      emit(
        state.copyWith(
          status: LoginStatus.success,
          user: response,
        ),
      );
    } on LoginRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on LoginFailure {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
