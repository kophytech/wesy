import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit(this.csRepository, this.regionCubit) : super(const RouteState()) {
    otherBlocSubscription = regionCubit.stream.listen((state) {
      if (state.status == RegionStatus.success) {
        addRegion(state.regions);
      } else {
        addRegion([]);
      }
    });
  }

  final CsRepository csRepository;
  late final StreamSubscription otherBlocSubscription;
  final RegionCubit regionCubit;

  void addRegion(List<Region> region) {
    region.insert(
      0,
      const Region(
        id: '',
        name: 'Select Region',
      ),
    );
    emit(state.copyWith(regions: region));
  }

  void updateAddRouteStatus() {
    emit(state.copyWith(addRouteStatus: AddRouteStatus.initial));
  }

  void onRouteNameChanged(String name) {
    emit(
      state.copyWith(
        routeName: name,
        addRouteStatus: AddRouteStatus.initial,
      ),
    );
  }

  void onRegionNameChanged(String region) {
    emit(
      state.copyWith(region: region, addRouteStatus: AddRouteStatus.initial),
    );
  }

  void onBranchChanged(String branch) {
    emit(
      state.copyWith(branch: branch, addRouteStatus: AddRouteStatus.initial),
    );
  }

  Future<void> getAllRoutes(int currentUser) async {
    try {
      emit(
        state.copyWith(
          status: RouteStatus.loading,
          deleteStatus: DeleteStatus.initial,
          addRouteStatus: AddRouteStatus.initial,
        ),
      );
      if (currentUser == 1) {
        final response = await csRepository.allWorkerRoutes();
        emit(
          state.copyWith(
            status: RouteStatus.success,
            deleteStatus: DeleteStatus.initial,
            addRouteStatus: AddRouteStatus.initial,
            routes: response,
          ),
        );
      } else {
        final response = await csRepository.allRoutes();
        emit(
          state.copyWith(
            status: RouteStatus.success,
            deleteStatus: DeleteStatus.initial,
            addRouteStatus: AddRouteStatus.initial,
            routes: response,
          ),
        );
      }
    } on AdminFailure {
      emit(
        state.copyWith(
          status: RouteStatus.failure,
          deleteStatus: DeleteStatus.initial,
          addRouteStatus: AddRouteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    } on AdminRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: RouteStatus.failure,
          deleteStatus: DeleteStatus.initial,
          addRouteStatus: AddRouteStatus.initial,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: RouteStatus.failure,
          deleteStatus: DeleteStatus.initial,
          addRouteStatus: AddRouteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  void updateRoute(Route route) {
    final routes = <Route>[];
    for (final route in state.routes) {
      routes.add(route);
    }
    routes.add(route);
    emit(state.copyWith(routes: routes));
  }

  Future<void> createRoute({bool hasRegion = true}) async {
    try {
      emit(
        state.copyWith(
          addRouteStatus: AddRouteStatus.loading,
          deleteStatus: DeleteStatus.initial,
        ),
      );
      final response = await csRepository.addRoute(
        name: state.routeName,
        region: state.region,
        type: state.branch,
        hasRegion: hasRegion,
      );
      updateRoute(Route.fromJson(response.data as Map<String, dynamic>));
      emit(
        state.copyWith(
          addRouteStatus: AddRouteStatus.success,
          deleteStatus: DeleteStatus.initial,
          successMessage: response.message,
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          addRouteStatus: AddRouteStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          addRouteStatus: AddRouteStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          addRouteStatus: AddRouteStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }

  Future<void> deleteRoute({String? routeId}) async {
    try {
      emit(state.copyWith(deleteStatus: DeleteStatus.loading));
      final response = await csRepository.deleteRoute(routeId: routeId);
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.success,
          successMessage: response.message ?? 'Deleted Successfully',
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    otherBlocSubscription.cancel();
    return super.close();
  }
}
