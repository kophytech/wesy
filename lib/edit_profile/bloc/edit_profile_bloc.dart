import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._authRepository) : super(const EditProfileState()) {
    on<EditProfileEmailChanged>(_onEmailChanged);
    on<EditProfileFirstNameChanged>(_onFirstNameChanged);
    on<EditProfileLastNameChanged>(_onLastNameChanged);
    on<EditProfileSubmitted>(_onSubmitted);
    on<EditProfileStarted>(_onEditProfileStarted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    EditProfileEmailChanged event,
    Emitter<EditProfileState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void _onFirstNameChanged(
    EditProfileFirstNameChanged event,
    Emitter<EditProfileState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: event.firstName,
        status: EditProfileStatus.initial,
      ),
    );
  }

  void _onLastNameChanged(
    EditProfileLastNameChanged event,
    Emitter<EditProfileState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: event.lastName,
        status: EditProfileStatus.initial,
      ),
    );
  }

  Future<void> _onEditProfileStarted(
    EditProfileStarted event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: EditProfileStatus.loading));
      final response = await _authRepository.getUserData();
      emit(
        state.copyWith(
          email: response.email,
          firstName: response.firstName,
          lastName: response.lastName,
          status: EditProfileStatus.success,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }

  Future<void> _onSubmitted(
    EditProfileSubmitted event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: EditProfileStatus.loading));
      final response = await _authRepository.changePassword(
        currentPassword: state.email,
        newPassword: state.firstName,
      );
      emit(
        state.copyWith(
          status: EditProfileStatus.success,
          successMessage: response,
        ),
      );
    } on ChangePasswordRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on ChangePasswordFailure {
      emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
