part of 'add_worker_bloc.dart';

abstract class AddWorkerEvent extends Equatable {
  const AddWorkerEvent();

  @override
  List<Object?> get props => [];
}

class AddWorkerEmailChanged extends AddWorkerEvent {
  const AddWorkerEmailChanged(this.email);

  final String email;
  @override
  List<Object?> get props => [email];
}

class RegionAdded extends AddWorkerEvent {
  const RegionAdded(this.regions);

  final List<Region> regions;
  @override
  List<Object?> get props => [regions];
}

class AddWorkerRegionChanged extends AddWorkerEvent {
  const AddWorkerRegionChanged(this.region);

  final String region;
  @override
  List<Object?> get props => [region];
}

class AddWorkerFirstNameChanged extends AddWorkerEvent {
  const AddWorkerFirstNameChanged(this.firstName);

  final String firstName;
  @override
  List<Object?> get props => [firstName];
}

class AddWorkerLastNameChanged extends AddWorkerEvent {
  const AddWorkerLastNameChanged(this.lastName);

  final String lastName;
  @override
  List<Object?> get props => [lastName];
}

class AddWorkerPasswordChanged extends AddWorkerEvent {
  const AddWorkerPasswordChanged(this.password);

  final String password;
  @override
  List<Object?> get props => [password];
}

class AddWorkerSubmitted extends AddWorkerEvent {
  const AddWorkerSubmitted();
}
