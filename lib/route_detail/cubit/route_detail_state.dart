part of 'route_detail_cubit.dart';

enum RouteDetailStatus { initial, loading, success, failure }

enum WorkerStatus { initial, loading, success, failure }

enum GetWorkerStatus { initial, loading, success, failure }

enum LocationStatus { initial, loading, success, failure }

class RouteDetailState extends Equatable {
  const RouteDetailState({
    this.status = RouteDetailStatus.loading,
    this.workerStatus = WorkerStatus.loading,
    this.locationStatus = LocationStatus.initial,
    this.getWorkerStatus = GetWorkerStatus.initial,
    this.successMessage = '',
    this.errorMessage = '',
    this.workers = const [],
    this.workersId = const [],
    this.details = const RouteDetails(),
    this.markers = const {},
  });

  RouteDetailState copyWith({
    RouteDetailStatus? status,
    WorkerStatus? workerStatus,
    RouteDetails? details,
    String? errorMessage,
    List<Worker>? workers,
    LocationStatus? locationStatus,
    String? successMessage,
    List<String>? workersId,
    Set<Marker>? markers,
    GetWorkerStatus? getWorkerStatus,
  }) {
    return RouteDetailState(
      status: status ?? this.status,
      workerStatus: workerStatus ?? this.workerStatus,
      details: details ?? this.details,
      errorMessage: errorMessage ?? this.errorMessage,
      workers: workers ?? this.workers,
      successMessage: successMessage ?? this.successMessage,
      locationStatus: locationStatus ?? this.locationStatus,
      workersId: workersId ?? this.workersId,
      markers: markers ?? this.markers,
      getWorkerStatus: getWorkerStatus ?? this.getWorkerStatus,
    );
  }

  final RouteDetailStatus status;
  final WorkerStatus workerStatus;
  final RouteDetails details;
  final String errorMessage;
  final List<Worker> workers;
  final LocationStatus locationStatus;
  final String successMessage;
  final GetWorkerStatus getWorkerStatus;
  final List<String> workersId;
  final Set<Marker> markers;

  @override
  List<Object> get props => [
        status,
        workerStatus,
        details,
        errorMessage,
        workers,
        locationStatus,
        successMessage,
        workersId,
        markers,
        getWorkerStatus,
      ];
}
