import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

part 'add_worker_event.dart';
part 'add_worker_state.dart';

class AddWorkerBloc extends Bloc<AddWorkerEvent, AddWorkerState> {
  AddWorkerBloc(this._csRepository, this.regionCubit)
      : super(const AddWorkerState()) {
    otherBlocSubscription = regionCubit.stream.listen((state) {
      if (state.status == RegionStatus.success) {
        add(RegionAdded(state.regions));
      } else {
        add(const RegionAdded([]));
      }
    });
    on<AddWorkerEmailChanged>(_onEmailChanged);
    on<AddWorkerFirstNameChanged>(_onFirstNameChanged);
    on<AddWorkerLastNameChanged>(_onLastNameChanged);
    on<AddWorkerPasswordChanged>(_onPasswordChanged);
    on<AddWorkerSubmitted>(_onSubmitted);
    on<RegionAdded>(_onRegionAdded);
    on<AddWorkerRegionChanged>(_onRegionChanged);
  }

  final CsRepository _csRepository;
  late final StreamSubscription otherBlocSubscription;
  final RegionCubit regionCubit;

  void _onEmailChanged(
    AddWorkerEmailChanged event,
    Emitter<AddWorkerState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        status: AddWorkerStatus.initial,
      ),
    );
  }

  void _onRegionAdded(RegionAdded event, Emitter<AddWorkerState> emit) {
    final regions = event.regions
      ..insert(
        0,
        const Region(
          id: '',
          name: 'Select Region',
        ),
      );
    emit(state.copyWith(regions: regions, status: AddWorkerStatus.initial));
  }

  void _onRegionChanged(
      AddWorkerRegionChanged event, Emitter<AddWorkerState> emit) {
    emit(state.copyWith(region: event.region, status: AddWorkerStatus.initial));
  }

  void _onFirstNameChanged(
    AddWorkerFirstNameChanged event,
    Emitter<AddWorkerState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: event.firstName,
        status: AddWorkerStatus.initial,
      ),
    );
  }

  void _onLastNameChanged(
    AddWorkerLastNameChanged event,
    Emitter<AddWorkerState> emit,
  ) {
    emit(
      state.copyWith(
        lastName: event.lastName,
        status: AddWorkerStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    AddWorkerPasswordChanged event,
    Emitter<AddWorkerState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        status: AddWorkerStatus.initial,
      ),
    );
  }

  Region getRegionWithId(String id) {
    final regions = state.regions;
    return regions.firstWhere((element) => element.id == id);
  }

  Future<void> _onSubmitted(
    AddWorkerSubmitted event,
    Emitter<AddWorkerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AddWorkerStatus.loading));
      final response = await _csRepository.addWorker(
        email: state.email,
        firstName: state.firstName,
        lastName: state.lastName,
        password: state.password,
        region: state.region,
      );
      final worker = Worker(
        id: response.data['user']['_id'] as String?,
        email: response.data['user']['email'] as String?,
        firstName: response.data['user']['firstName'] as String?,
        lastName: response.data['user']['lastName'] as String?,
        roles: (response.data['user']['roles'] as List)
            .map((dynamic e) => e as String)
            .toList(),
        region: getRegionWithId(response.data['user']['region'] as String),
      );
      emit(
        state.copyWith(
          status: AddWorkerStatus.success,
          successMessage: response.message,
          worker: worker,
        ),
      );
    } on AddWorkerFailure {
      emit(
        state.copyWith(
          status: AddWorkerStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on AddWorkerRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: AddWorkerStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: AddWorkerStatus.failure,
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
