part of 'region_cubit.dart';

enum RegionStatus {
  loading,
  success,
  failure,
}

enum AddRegionStatus {
  initial,
  loading,
  success,
  failure,
}

class RegionState extends Equatable {
  const RegionState({
    this.status = RegionStatus.loading,
    this.regions = const [],
    this.errorMessage = '',
    this.addRegionStatus = AddRegionStatus.initial,
    this.region = '',
    this.successMessage = '',
  });

  RegionState copyWith({
    RegionStatus? status,
    List<Region>? regions,
    String? errorMessage,
    AddRegionStatus? addRegionStatus,
    String? region,
    String? successMessage,
  }) {
    return RegionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      regions: regions ?? this.regions,
      addRegionStatus: addRegionStatus ?? this.addRegionStatus,
      region: region ?? this.region,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  final RegionStatus status;
  final AddRegionStatus addRegionStatus;
  final String region;
  final List<Region> regions;
  final String errorMessage;
  final String successMessage;

  @override
  List<Object> get props =>
      [status, regions, errorMessage, addRegionStatus, region, successMessage];
}
