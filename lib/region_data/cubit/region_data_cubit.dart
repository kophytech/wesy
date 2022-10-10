import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'region_data_state.dart';

class RegionDataCubit extends Cubit<RegionDataState> {
  RegionDataCubit(this.csRepository) : super(const RegionDataState());

  final CsRepository csRepository;

  Future<void> getRegionStats(String regionId) async {
    try {
      emit(state.copyWith(status: RegionDataStatus.loading));
      final response = await csRepository.regionDetails(regionId);

      emit(
        state.copyWith(
          status: RegionDataStatus.success,
          regionStats: response,
        ),
      );
    } on RegionFailure {
      emit(
        state.copyWith(
          status: RegionDataStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    } on RegionRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: RegionDataStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: RegionDataStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> getRegionPinStats(String regionId) async {
    try {
      emit(state.copyWith(regionDataPinStatus: RegionDataPinStatus.loading));
      final response = await csRepository.regionPinStats(regionId);

      emit(
        state.copyWith(
          regionDataPinStatus: RegionDataPinStatus.success,
          regionStats: response,
        ),
      );
    } on RegionFailure {
      emit(
        state.copyWith(
          regionDataPinStatus: RegionDataPinStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    } on RegionRequestFailure catch (e) {
      emit(
        state.copyWith(
          regionDataPinStatus: RegionDataPinStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          regionDataPinStatus: RegionDataPinStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> getRouteStats(String regionId) async {
    try {
      emit(
          state.copyWith(regionDataRouteStatus: RegionDataRouteStatus.loading));
      final response = await csRepository.regionRouteStats(regionId);

      emit(
        state.copyWith(
          regionDataRouteStatus: RegionDataRouteStatus.success,
          routeDetails: response,
        ),
      );
    } on RegionFailure {
      emit(
        state.copyWith(
          regionDataRouteStatus: RegionDataRouteStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    } on RegionRequestFailure catch (e) {
      emit(
        state.copyWith(
          regionDataRouteStatus: RegionDataRouteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          regionDataRouteStatus: RegionDataRouteStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
