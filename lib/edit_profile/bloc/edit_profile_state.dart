part of 'edit_profile_bloc.dart';

enum EditProfileStatus { initial, loading, success, failure }

class EditProfileState extends Equatable {
  const EditProfileState({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.status = EditProfileStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
  });

  EditProfileState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    EditProfileStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  final String email;
  final String firstName;
  final String lastName;
  final EditProfileStatus status;
  final String errorMessage;
  final String successMessage;

  @override
  List<Object> get props =>
      [email, firstName, lastName, status, errorMessage, successMessage];
}
