import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wesy/app/bloc/app_bloc.dart';
import 'package:wesy/home/view/home_body.dart';
import 'package:wesy/notification/notification.dart';
import 'package:wesy/region/region.dart';
import 'package:wesy/setting/setting.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required CsRepository csRepository})
      : _csRepository = csRepository,
        super(const HomeState()) {
    on<HomeStarted>(_initialEvent);
    on<CurrentIndexChanged>(_onCurrentIndexChanged);
    on<GetRouteTypeStats>(_onGetRouteTypeStats);
    on<GetPinPotentialStats>(_onPinPotentialStats);
    on<GetRegionStats>(_onRegionStats);
    on<GetRegionConstructionStats>(_onRegionConstructionStats);
    on<GetConstructionBranchStats>(_onConstructionBranchStats);
    on<GetStoreBranchStats>(_onStoreBranchStats);
    on<GetIndustryBranchStats>(_onIndustryBranchStats);
    on<GetWorkerRouteCount>(_onGetWorkerRouteCount);
    on<GetRouteCount>(_onRouteCount);
  }

  final CsRepository _csRepository;

  Future<void> _initialEvent(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        scaffoldKey: GlobalKey<ScaffoldState>(),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 20), () {});
    if (event.appState!.user.roles!.length == 1) {
      add(const GetWorkerRouteCount());
    } else if (event.appState!.user.roles!.length == 2) {
      add(const GetPinPotentialStats());
      add(const GetRouteCount());
    } else {
      add(const GetPinPotentialStats());
      add(const GetRouteTypeStats());
      add(const GetRegionStats());
      add(const GetRegionConstructionStats());
      add(GetConstructionBranchStats(year: DateTime.now().year.toString()));
      add(GetStoreBranchStats(year: DateTime.now().year.toString()));
      add(GetIndustryBranchStats(year: DateTime.now().year.toString()));
    }
    add(const GetWorkerRouteCount());
  }

  void _onCurrentIndexChanged(
    CurrentIndexChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.currentIndex));
  }

  Future<void> _onGetRouteTypeStats(
    GetRouteTypeStats event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(routeTypeStatus: RouteTypeStatus.loading));
      final response = await _csRepository.routeTypeStats();
      emit(
        state.copyWith(
          routeTypeStatus: RouteTypeStatus.success,
          routeTypeStats: response,
        ),
      );
    } on Exception {
      emit(state.copyWith(routeTypeStatus: RouteTypeStatus.failure));
    }
  }

  Future<void> _onGetWorkerRouteCount(
    GetWorkerRouteCount event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(workerRouteStatus: WorkerRouteStatus.loading));
      final response = await _csRepository.getWorkerRouteCount();
      emit(
        state.copyWith(
          workerRouteStatus: WorkerRouteStatus.success,
          workerRouteCount: response.toString(),
        ),
      );
    } on Exception {
      emit(state.copyWith(workerRouteStatus: WorkerRouteStatus.failure));
    }
  }

  Future<void> _onRouteCount(
    GetRouteCount event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(routeCountStatus: RouteCountStatus.loading));
      final response = await _csRepository.getRouteCount();
      emit(
        state.copyWith(
          routeCountStatus: RouteCountStatus.success,
          routeCount: response,
        ),
      );
    } on Exception {
      emit(state.copyWith(routeCountStatus: RouteCountStatus.failure));
    }
  }

  Future<void> _onPinPotentialStats(
    GetPinPotentialStats event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(pinPotentialStatus: PinPotentialStatus.loading));
      final response = await _csRepository.pinPotentialStats();
      emit(
        state.copyWith(
          pinPotentialStatus: PinPotentialStatus.success,
          pinPotentialStats: response,
        ),
      );
    } on Exception {
      emit(state.copyWith(pinPotentialStatus: PinPotentialStatus.failure));
    }
  }

  Future<void> _onRegionStats(
    GetRegionStats event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(regionsStatus: RegionsStatus.loading));
      final response = await _csRepository.regionStats();
      emit(
        state.copyWith(
          regionsStatus: RegionsStatus.success,
          regionStats: response,
        ),
      );
    } on Exception {
      emit(state.copyWith(regionsStatus: RegionsStatus.failure));
    }
  }

  Future<void> _onRegionConstructionStats(
    GetRegionConstructionStats event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          regionConstructionStatus: RegionConstructionStatus.loading,
        ),
      );
      final response = await _csRepository.regionConstructionStats();
      emit(
        state.copyWith(
          regionConstructionStatus: RegionConstructionStatus.success,
          regionConstructionStats: response,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          regionConstructionStatus: RegionConstructionStatus.failure,
        ),
      );
    }
  }

  Future<void> _onConstructionBranchStats(
    GetConstructionBranchStats event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          constructionBranchStatus: ConstructionBranchStatus.loading,
        ),
      );
      final response =
          await _csRepository.constructionBranchStats(year: event.year);
      emit(
        state.copyWith(
          constructionBranchStatus: ConstructionBranchStatus.success,
          constructionBranchStats: response,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          constructionBranchStatus: ConstructionBranchStatus.failure,
        ),
      );
    }
  }

  Future<void> _onStoreBranchStats(
    GetStoreBranchStats event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          storeBranchStatus: StoreBranchStatus.loading,
        ),
      );
      final response = await _csRepository.storeBranchStats(year: event.year);
      emit(
        state.copyWith(
          storeBranchStatus: StoreBranchStatus.success,
          storeBranchStats: response,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          storeBranchStatus: StoreBranchStatus.failure,
        ),
      );
    }
  }

  Future<void> _onIndustryBranchStats(
    GetIndustryBranchStats event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          industryBranchStatus: IndustryBranchStatus.loading,
        ),
      );
      final response =
          await _csRepository.industryBranchStats(year: event.year);
      emit(
        state.copyWith(
          industryBranchStatus: IndustryBranchStatus.success,
          industryBranchStats: response,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          industryBranchStatus: IndustryBranchStatus.failure,
        ),
      );
    }
  }
}
