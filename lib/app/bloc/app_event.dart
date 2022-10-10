part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppStatusChanged extends AppEvent {
  const AppStatusChanged({this.status});

  final AuthStatus? status;

  @override
  List<Object?> get props => [status];
}

class AppUserUpdated extends AppEvent {
  const AppUserUpdated({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}

class AppGetCurrentLocation extends AppEvent {
  const AppGetCurrentLocation();
}

class SetLocale extends AppEvent {
  const SetLocale(this.locale);
  final String locale;
}

class AppFCMToken extends AppEvent {
  const AppFCMToken();
}
