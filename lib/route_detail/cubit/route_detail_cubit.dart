import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'route_detail_state.dart';

class RouteDetailCubit extends Cubit<RouteDetailState> {
  RouteDetailCubit(this.csRepository) : super(const RouteDetailState());

  final CsRepository csRepository;

  void initialize() {
    if (state.markers.isNotEmpty) {
      state.markers.clear();
    }
  }

  void onMarkerChanged(Marker marker) {
    final markers = <Marker>{};

    for (final data in state.markers) {
      markers.add(data);
    }

    markers.add(marker);

    emit(state.copyWith(markers: markers));
  }

  Future<String?> changePinPosition(
      int pinIndex, int pinNewIndex, String routeId) {
    final currentDetails = state.details;
    final pin = currentDetails.pins![pinIndex];
    currentDetails.pins!.removeAt(pinIndex);
    currentDetails.pins!.insert(pinNewIndex, pin);
    final pinIds = <String>[];
    for (final pin in currentDetails.pins!) {
      pinIds.add(pin.id ?? '');
    }
    emit(state.copyWith(details: currentDetails));
    return reArragePin(pins: pinIds, routeId: routeId);
  }

  void addMarker(Set<Marker>? markers) {
    if (markers == null) return;
    if (markers.isEmpty) return;
    emit(state.copyWith(markers: markers));
  }

  void updateLocationPin(Pin pin) {
    // final currentDetailsJsonData = state.details.toJson();
    // final pins = currentDetailsJsonData['pins'] as List;
    // pins.add(pin);
    // currentDetailsJsonData['pins'] = pins;
    // final newDetails = RouteDetails.fromJson(currentDetailsJsonData);
    final pins = <Pin>[];
    if (state.details.pins != null) {
      for (final pin in state.details.pins!) {
        pins.add(pin);
      }
    }
    pins.add(pin);
    final currentDetails = state.details.toJson();
    currentDetails['pins'] = pins.map((e) => e.toJson()).toList();
    final newDetails = RouteDetails.fromJson(currentDetails);
    emit(state.copyWith(details: newDetails));
  }

  // void onAddPolylines(LatLng latLng1, LatLng latLng2) async {
  //   final PolylineResult result =
  //       await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyAZ8qO-8-ZBW3TzNzBfhUCBNxpU8-EX9ss',
  //     PointLatLng(latLng1.latitude, latLng1.longitude),
  //     PointLatLng(latLng2.latitude, latLng2.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }
  //   }
  //   print('===============');
  //   print(polylineCoordinates);
  //   print('===============');
  //   var polyline = Polyline(
  //     polylineId: const PolylineId('1'),
  //     color: Color(0xFF3277D8),
  //     points: polylineCoordinates,
  //     width: 4,
  //   );
  //   polyLines.add(polyline);
  //   setState(() {});
  // }

  void onWorkerIdChanged(String id) {
    final ids = <String>[];

    for (final workerId in state.workersId) {
      ids.add(workerId);
    }

    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }

    emit(state.copyWith(workersId: ids));
  }

  Future<void> getRouteDetails({String? routeId}) async {
    try {
      emit(
        state.copyWith(
          status: RouteDetailStatus.loading,
          workerStatus: WorkerStatus.initial,
          locationStatus: LocationStatus.initial,
        ),
      );
      final response = await csRepository.getRouteDetails(routeId: routeId);
      emit(
        state.copyWith(
          status: RouteDetailStatus.success,
          workerStatus: WorkerStatus.initial,
          locationStatus: LocationStatus.initial,
          details: response,
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          status: RouteDetailStatus.failure,
          workerStatus: WorkerStatus.initial,
          locationStatus: LocationStatus.initial,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: RouteDetailStatus.failure,
          workerStatus: WorkerStatus.initial,
          locationStatus: LocationStatus.initial,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: RouteDetailStatus.failure,
          workerStatus: WorkerStatus.initial,
          locationStatus: LocationStatus.initial,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }

  Future<bool> workerSubmitted({String? routeId}) async {
    try {
      final response = await csRepository.addRouteWorker(
        routeId: routeId,
        workers: state.workersId,
      );
      return true;
    } on RouteFailure {
      return false;
    } on RouteRequestFailure {
      return false;
    } on Exception {
      return false;
    }
  }

  Future<String?> reArragePin({String? routeId, List<String>? pins}) async {
    try {
      final response = await csRepository.reArrangePin(
        routeId: routeId,
        pin: pins,
      );
      return response.message;
    } on RouteFailure {
      return null;
    } on RouteRequestFailure {
      return null;
    } on Exception {
      return null;
    }
  }

  Future<void> deleteLocation({String? routeId, String? locationId}) async {
    try {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.loading,
          workerStatus: WorkerStatus.initial,
        ),
      );
      final response = await csRepository.deleteRouteLocation(
        locationId: locationId,
      );
      emit(
        state.copyWith(
          locationStatus: LocationStatus.success,
          successMessage: response.message,
          workerStatus: WorkerStatus.initial,
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.failure,
          errorMessage: 'Something went wrong, Try again',
          workerStatus: WorkerStatus.initial,
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.failure,
          errorMessage: e.toString(),
          workerStatus: WorkerStatus.initial,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.failure,
          errorMessage: 'Something went wrong, Try again',
          workerStatus: WorkerStatus.initial,
        ),
      );
    }
  }

  Future<void> deleteWorker({String? routeId, String? workerId}) async {
    try {
      emit(
        state.copyWith(
          workerStatus: WorkerStatus.loading,
          locationStatus: LocationStatus.initial,
        ),
      );
      final response = await csRepository.deleteRouteWorker(
        workerId: workerId,
        routeId: routeId,
      );
      emit(
        state.copyWith(
          workerStatus: WorkerStatus.success,
          successMessage: response.message,
          locationStatus: LocationStatus.initial,
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          workerStatus: WorkerStatus.failure,
          locationStatus: LocationStatus.initial,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          workerStatus: WorkerStatus.failure,
          locationStatus: LocationStatus.initial,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          workerStatus: WorkerStatus.failure,
          locationStatus: LocationStatus.initial,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }

  Future<void> getWorkers({String? region}) async {
    try {
      emit(state.copyWith(getWorkerStatus: GetWorkerStatus.loading));
      final response = await csRepository.getWorkers(region: region);
      emit(
        state.copyWith(
          getWorkerStatus: GetWorkerStatus.success,
          workers: response,
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          getWorkerStatus: GetWorkerStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          getWorkerStatus: GetWorkerStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          getWorkerStatus: GetWorkerStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
