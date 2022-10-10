part of 'create_bloc.dart';

enum CreateStatus {
  initial,
  loading,
  success,
  failure,
}

class CreateState extends Equatable {
  const CreateState({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.password = '',
    this.status = CreateStatus.initial,
    this.regions = const [],
    this.region = '',
    this.errorMessage = '',
    this.successMessage = '',
    this.admin = const Admin(),
  });

  CreateState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? region,
    CreateStatus? status,
    List<Region>? regions,
    String? errorMessage,
    String? successMessage,
    Admin? admin,
  }) {
    return CreateState(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      region: region ?? this.region,
      status: status ?? this.status,
      regions: regions ?? this.regions,
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
  final CreateStatus status;
  final List<Region> regions;
  final String successMessage;
  final String errorMessage;
  final Admin admin;

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        region,
        password,
        status,
        admin,
        regions,
        successMessage,
        errorMessage,
      ];
}
