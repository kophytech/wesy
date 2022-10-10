import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(this._authRepository)
      : super(const ChangePasswordState()) {
    on<ChangePasswordCurrentChanged>(_onCurrentPasswordChanged);
    on<ChangePasswordNewChanged>(_onNewPasswordChanged);
    on<ChangePasswordSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onCurrentPasswordChanged(
    ChangePasswordCurrentChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(
      state.copyWith(
        currentPassword: event.currentPassword,
        status: ChangePasswordStatus.initial,
      ),
    );
  }

  void _onNewPasswordChanged(
    ChangePasswordNewChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(
      state.copyWith(
        newPassword: event.newPassword,
        status: ChangePasswordStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ChangePasswordStatus.loading));
      final response = await _authRepository.changePassword(
        currentPassword: state.currentPassword,
        newPassword: state.newPassword,
      );
      emit(
        state.copyWith(
          status: ChangePasswordStatus.success,
          successMessage: response,
        ),
      );
    } on ChangePasswordRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on ChangePasswordFailure {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
