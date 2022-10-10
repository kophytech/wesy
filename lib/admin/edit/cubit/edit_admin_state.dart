part of 'edit_admin_cubit.dart';

enum EditStatus {
  initial,
  loading,
  success,
  failure,
}

enum AdminDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class EditAdminState extends Equatable {
  const EditAdminState({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.password = '',
    this.status = EditStatus.initial,
    this.regions = const [],
    this.region = '',
    this.errorMessage = '',
    this.successMessage = '',
    this.adminDetailsStatus = AdminDetailsStatus.loading,
    this.adminId = '',
    this.admin = const AdminDetails(),
  });

  EditAdminState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
    EditStatus? status,
    List<Region>? regions,
    String? errorMessage,
    String? successMessage,
    String? adminId,
    AdminDetailsStatus? adminDetailsStatus,
    AdminDetails? admin,
  }) {
    return EditAdminState(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      region: region ?? this.region,
      status: status ?? this.status,
      regions: regions ?? this.regions,
      adminDetailsStatus: adminDetailsStatus ?? this.adminDetailsStatus,
      adminId: adminId ?? this.adminId,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      admin: admin ?? this.admin,
    );
  }

  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String region;
  final EditStatus status;
  final AdminDetailsStatus adminDetailsStatus;
  final List<Region> regions;
  final String successMessage;
  final String errorMessage;
  final String adminId;
  final AdminDetails admin;

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        region,
        password,
        status,
        adminDetailsStatus,
        adminId,
        regions,
        successMessage,
        errorMessage,
        admin,
      ];
}
