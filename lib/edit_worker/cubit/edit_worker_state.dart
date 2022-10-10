part of 'edit_worker_cubit.dart';

enum EditStatus {
  initial,
  loading,
  success,
  failure,
}

enum WorkerDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class EditWorkerState extends Equatable {
  const EditWorkerState({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.password = '',
    this.status = EditStatus.initial,
    this.regions = const [],
    this.region = '',
    this.errorMessage = '',
    this.successMessage = '',
    this.workerDetailsStatus = WorkerDetailsStatus.loading,
    this.workerId = '',
    this.admin = const AdminDetails(),
  });

  EditWorkerState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
    EditStatus? status,
    List<Region>? regions,
    String? errorMessage,
    String? successMessage,
    String? workerId,
    WorkerDetailsStatus? workerDetailsStatus,
    AdminDetails? admin,
  }) {
    return EditWorkerState(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      region: region ?? this.region,
      status: status ?? this.status,
      regions: regions ?? this.regions,
      workerDetailsStatus: workerDetailsStatus ?? this.workerDetailsStatus,
      workerId: workerId ?? this.workerId,
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
  final WorkerDetailsStatus workerDetailsStatus;
  final List<Region> regions;
  final String successMessage;
  final String errorMessage;
  final String workerId;
  final AdminDetails admin;

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        region,
        password,
        status,
        workerDetailsStatus,
        workerId,
        regions,
        successMessage,
        errorMessage,
        admin,
      ];
}
