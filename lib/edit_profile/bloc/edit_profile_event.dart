part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditProfileEmailChanged extends EditProfileEvent {
  const EditProfileEmailChanged(this.email);

  final String email;
  @override
  List<Object> get props => [email];
}

class EditProfileFirstNameChanged extends EditProfileEvent {
  const EditProfileFirstNameChanged(this.firstName);

  final String firstName;
  @override
  List<Object> get props => [firstName];
}

class EditProfileLastNameChanged extends EditProfileEvent {
  const EditProfileLastNameChanged(this.lastName);

  final String lastName;
  @override
  List<Object> get props => [lastName];
}

class EditProfileSubmitted extends EditProfileEvent {
  const EditProfileSubmitted();
}

class EditProfileStarted extends EditProfileEvent {
  const EditProfileStarted();
}
