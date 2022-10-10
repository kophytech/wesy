import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'region_state.dart';

class RegionCubit extends Cubit<RegionState> {
  RegionCubit(this.csRepository) : super(const RegionState());

  final CsRepository csRepository;

  void onRegionNameChanged(String name) {
    emit(
      state.copyWith(
        region: name,
        addRegionStatus: AddRegionStatus.initial,
      ),
    );
  }

  Future<void> addRegion() async {
    try {
      emit(state.copyWith(addRegionStatus: AddRegionStatus.loading));
      final response = await csRepository.addRegion(name: state.region);

      emit(
        state.copyWith(
          addRegionStatus: AddRegionStatus.success,
          successMessage: response.message,
        ),
      );
    } on RegionFailure {
      emit(
        state.copyWith(
          addRegionStatus: AddRegionStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    } on RegionRequestFailure catch (e) {
      emit(
        state.copyWith(
          addRegionStatus: AddRegionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          addRegionStatus: AddRegionStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> getAllRegions() async {
    try {
      emit(state.copyWith(status: RegionStatus.loading));
      final response = await csRepository.allRegions();

      emit(
        state.copyWith(
          status: RegionStatus.success,
          regions: response
            ..sort(
              (a, b) => a.name!.compareTo(b.name!),
            ),
        ),
      );
    } on RegionFailure {
      emit(
        state.copyWith(
          status: RegionStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    } on RegionRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: RegionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: RegionStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
