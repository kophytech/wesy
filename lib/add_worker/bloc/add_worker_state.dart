part of 'add_worker_bloc.dart';

enum AddWorkerStatus {
  initial,
  loading,
  success,
  failure,
}

class AddWorkerState extends Equatable {
  const AddWorkerState({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.password = '',
    this.status = AddWorkerStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.regions = const [],
    this.region = '',
    this.worker = const Worker(),
  });

  AddWorkerState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    AddWorkerStatus? status,
    String? errorMessage,
    String? successMessage,
    List<Region>? regions,
    String? region,
    Worker? worker,
  }) {
    return AddWorkerState(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      regions: regions ?? this.regions,
      region: region ?? this.region,
      worker: worker ?? this.worker,
    );
  }

  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final AddWorkerStatus status;
  final List<Region> regions;
  final String region;
  final String errorMessage;
  final String successMessage;
  final Worker worker;

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        password,
        status,
        worker,
        regions,
        region,
        errorMessage,
        successMessage,
      ];
}
