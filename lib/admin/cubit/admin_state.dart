part of 'admin_cubit.dart';

enum AdminStatus { loading, success, failure }

enum DeleteStatus { initial, loading, success, failure }

class AdminState extends Equatable {
  const AdminState({
    this.status = AdminStatus.loading,
    this.admins = const [],
    this.errorMessage = '',
    this.successMessage = '',
    this.deleteStatus = DeleteStatus.initial,
  });

  AdminState copyWith({
    AdminStatus? status,
    List<Admin>? admins,
    String? errorMessage,
    DeleteStatus? deleteStatus,
    String? successMessage,
  }) {
    return AdminState(
      status: status ?? this.status,
      admins: admins ?? this.admins,
      errorMessage: errorMessage ?? this.errorMessage,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  final AdminStatus status;
  final List<Admin> admins;
  final String errorMessage;
  final DeleteStatus deleteStatus;
  final String successMessage;

  @override
  List<Object> get props =>
      [status, admins, errorMessage, deleteStatus, successMessage];
}
