part of 'change_password_bloc.dart';

enum ChangePasswordStatus { initial, loading, success, failure }

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.status = ChangePasswordStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
  });

  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    ChangePasswordStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  final String currentPassword;
  final String newPassword;
  final ChangePasswordStatus status;
  final String errorMessage;
  final String successMessage;

  @override
  List<Object> get props =>
      [currentPassword, newPassword, status, errorMessage, successMessage];
}
