part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  const HomeStarted({this.appState});
  final AppState? appState;

  @override
  List<Object?> get props => [appState];
}

class CurrentIndexChanged extends HomeEvent {
  const CurrentIndexChanged({required this.currentIndex});

  final int currentIndex;

  @override
  List<Object> get props => [currentIndex];
}

class GetRouteTypeStats extends HomeEvent {
  const GetRouteTypeStats();
}

class GetPinPotentialStats extends HomeEvent {
  const GetPinPotentialStats();
}

class GetRegionStats extends HomeEvent {
  const GetRegionStats();
}

class GetRegionConstructionStats extends HomeEvent {
  const GetRegionConstructionStats();
}

class GetConstructionBranchStats extends HomeEvent {
  const GetConstructionBranchStats({this.year});

  final String? year;

  @override
  List<Object?> get props => [year];
}

class GetStoreBranchStats extends HomeEvent {
  const GetStoreBranchStats({this.year});

  final String? year;

  @override
  List<Object?> get props => [year];
}

class GetIndustryBranchStats extends HomeEvent {
  const GetIndustryBranchStats({this.year});

  final String? year;

  @override
  List<Object?> get props => [year];
}

class GetWorkerRouteCount extends HomeEvent {
  const GetWorkerRouteCount();
}

class GetRouteCount extends HomeEvent {
  const GetRouteCount();
}
