part of 'route_cubit.dart';

enum RouteStatus { loading, success, failure }

enum AddRouteStatus { initial, loading, success, failure }

enum DeleteStatus { initial, loading, success, failure }

class RouteState extends Equatable {
  const RouteState({
    this.status = RouteStatus.loading,
    this.addRouteStatus = AddRouteStatus.initial,
    this.routes = const [],
    this.regions = const [],
    this.errorMessage = '',
    this.successMessage = '',
    this.routeName = '',
    this.region = '',
    this.branch = '',
    this.deleteStatus = DeleteStatus.initial,
  });

  RouteState copyWith({
    RouteStatus? status,
    List<Route>? routes,
    String? errorMessage,
    AddRouteStatus? addRouteStatus,
    List<Region>? regions,
    String? successMessage,
    String? routeName,
    String? region,
    String? branch,
    DeleteStatus? deleteStatus,
  }) {
    return RouteState(
      status: status ?? this.status,
      routes: routes ?? this.routes,
      errorMessage: errorMessage ?? this.errorMessage,
      addRouteStatus: addRouteStatus ?? this.addRouteStatus,
      regions: regions ?? this.regions,
      successMessage: successMessage ?? this.successMessage,
      routeName: routeName ?? this.routeName,
      region: region ?? this.region,
      branch: branch ?? this.branch,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  final RouteStatus status;
  final List<Route> routes;
  final String errorMessage;
  final AddRouteStatus addRouteStatus;
  final List<Region> regions;
  final String successMessage;
  final String routeName;
  final String region;
  final String branch;
  final DeleteStatus deleteStatus;

  @override
  List<Object> get props => [
        status,
        routes,
        errorMessage,
        addRouteStatus,
        regions,
        successMessage,
        routeName,
        region,
        branch,
        deleteStatus,
      ];
}
