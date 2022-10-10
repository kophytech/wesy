part of 'region_data_cubit.dart';

enum RegionDataStatus {
  loading,
  success,
  failure,
}

enum RegionDataPinStatus {
  loading,
  success,
  failure,
}

enum RegionDataRouteStatus {
  loading,
  success,
  failure,
}

class RegionDataState extends Equatable {
  const RegionDataState({
    this.status = RegionDataStatus.loading,
    this.regionDataPinStatus = RegionDataPinStatus.loading,
    this.regionDataRouteStatus = RegionDataRouteStatus.loading,
    this.errorMessage = '',
    this.successMessage = '',
    this.regionStats = const [],
    this.pinStats = const [],
    this.routeDetails = const [],
  });

  RegionDataState copyWith({
    RegionDataStatus? status,
    RegionDataPinStatus? regionDataPinStatus,
    String? errorMessage,
    String? successMessage,
    List<RouteTypeStats>? regionStats,
    List<RouteTypeStats>? pinStats,
    RegionDataRouteStatus? regionDataRouteStatus,
    List<RegionRoute>? routeDetails,
  }) {
    return RegionDataState(
      status: status ?? this.status,
      regionDataPinStatus: regionDataPinStatus ?? this.regionDataPinStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      regionStats: regionStats ?? this.regionStats,
      pinStats: pinStats ?? this.pinStats,
      routeDetails: routeDetails ?? this.routeDetails,
      regionDataRouteStatus:
          regionDataRouteStatus ?? this.regionDataRouteStatus,
    );
  }

  final RegionDataStatus status;
  final RegionDataPinStatus regionDataPinStatus;
  final String errorMessage;
  final String successMessage;
  final List<RouteTypeStats> regionStats;
  final List<RouteTypeStats> pinStats;
  final RegionDataRouteStatus regionDataRouteStatus;
  final List<RegionRoute> routeDetails;

  @override
  List<Object> get props => [
        status,
        regionDataPinStatus,
        pinStats,
        regionStats,
        errorMessage,
        successMessage,
        regionDataRouteStatus,
        routeDetails,
      ];
}
