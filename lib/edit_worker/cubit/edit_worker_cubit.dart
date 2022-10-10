import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

part 'edit_worker_state.dart';

class EditWorkerCubit extends Cubit<EditWorkerState> {
  EditWorkerCubit(
      {required CsRepository csRepository, required RegionCubit regionCubit})
      : _csRepository = csRepository,
        _regionCubit = regionCubit,
        super(const EditWorkerState()) {
    otherBlocSubscription = regionCubit.stream.listen((state) {
      if (state.status == RegionStatus.success) {
        _onRegionAdded(state.regions);
      } else {
        _onRegionAdded([]);
      }
    });
  }

  final CsRepository _csRepository;
  late final StreamSubscription otherBlocSubscription;
  final RegionCubit _regionCubit;

  void _onRegionAdded(List<Region> getRegions) {
    final regions = getRegions
      ..insert(
        0,
        const Region(
          id: '',
          name: 'Select Region',
        ),
      );
    emit(state.copyWith(regions: regions, status: EditStatus.initial));
  }

  void onRegionChanged(String region) {
    emit(state.copyWith(region: region, status: EditStatus.initial));
  }

  void onWorkerIdChanged(String workerId) {
    emit(state.copyWith(workerId: workerId, status: EditStatus.initial));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email, status: EditStatus.initial));
  }

  void onFirstNameChanged(String firstName) {
    emit(
      state.copyWith(
        firstName: firstName,
        status: EditStatus.initial,
      ),
    );
  }

  void onLastNameChanged(String lastName) {
    emit(
      state.copyWith(lastName: lastName, status: EditStatus.initial),
    );
  }

  void onPasswordChanged(String password) {
    emit(
      state.copyWith(password: password, status: EditStatus.initial),
    );
  }

  Future<void> getWorkerDetails(String workderId) async {
    try {
      emit(state.copyWith(workerDetailsStatus: WorkerDetailsStatus.loading));
      final response = await _csRepository.getWorkerDetails(workderId);
      emit(
        state.copyWith(
          workerDetailsStatus: WorkerDetailsStatus.success,
          firstName: response.firstName,
          lastName: response.lastName,
          email: response.email,
          region: response.region,
          status: EditStatus.initial,
        ),
      );
    } on WorkerFailure {
      emit(
        state.copyWith(
          workerDetailsStatus: WorkerDetailsStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on WorkerRequestFailure catch (e) {
      emit(
        state.copyWith(
          workerDetailsStatus: WorkerDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          workerDetailsStatus: WorkerDetailsStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }

  Future<void> onSubmitted() async {
    try {
      emit(state.copyWith(status: EditStatus.loading));
      final response = await _csRepository.editWorker(
        email: state.email,
        firstName: state.firstName,
        lastName: state.lastName,
        password: state.password,
        region: state.region,
        id: state.workerId,
      );
      emit(
        state.copyWith(
          status: EditStatus.success,
          successMessage: response.message,
        ),
      );
    } on WorkerFailure {
      emit(
        state.copyWith(
          status: EditStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on WorkerRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: EditStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: EditStatus.failure,
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
