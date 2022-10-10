part of 'create_bloc.dart';

abstract class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object?> get props => [];
}

class RegionAdded extends CreateEvent {
  const RegionAdded(this.regions);

  final List<Region> regions;
  @override
  List<Object?> get props => [regions];
}

class CreateEmailChanged extends CreateEvent {
  const CreateEmailChanged(this.email);

  final String email;
  @override
  List<Object?> get props => [email];
}

class CreateFirstNameChanged extends CreateEvent {
  const CreateFirstNameChanged(this.firstName);

  final String firstName;
  @override
  List<Object?> get props => [firstName];
}

class CreateLastNameChanged extends CreateEvent {
  const CreateLastNameChanged(this.lastName);

  final String lastName;
  @override
  List<Object?> get props => [lastName];
}

class CreateRegionChanged extends CreateEvent {
  const CreateRegionChanged(this.region);

  final String region;
  @override
  List<Object?> get props => [region];
}

class CreatePasswordChanged extends CreateEvent {
  const CreatePasswordChanged(this.password);

  final String password;
  @override
  List<Object?> get props => [password];
}

class CreateSubmitted extends CreateEvent {
  const CreateSubmitted();
}
