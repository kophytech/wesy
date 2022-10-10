part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.status = AuthStatus.unknown,
    this.user = const User(),
    this.currentLocation = const LatLng(0, 0),
    this.deviceToken = '',
    this.currentLocale = 'de',
  });

  AppState copyWith(
      {AuthStatus? status,
      User? user,
      LatLng? currentLocation,
      String? deviceToken,
      String? currentLocale}) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      currentLocation: currentLocation ?? this.currentLocation,
      deviceToken: deviceToken ?? this.deviceToken,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }

  final AuthStatus status;
  final User user;
  final LatLng currentLocation;
  final String deviceToken;
  final String currentLocale;

  @override
  List<Object> get props =>
      [status, user, currentLocation, deviceToken, currentLocale];
}
