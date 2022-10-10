part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordCurrentChanged extends ChangePasswordEvent {
  const ChangePasswordCurrentChanged(this.currentPassword);

  final String currentPassword;
  @override
  List<Object> get props => [];
}

class ChangePasswordNewChanged extends ChangePasswordEvent {
  const ChangePasswordNewChanged(this.newPassword);

  final String newPassword;
  @override
  List<Object> get props => [];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  const ChangePasswordSubmitted();
}
