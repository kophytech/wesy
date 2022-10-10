import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:wesy/region/cubit/region_cubit.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc(this._csRepository, this.regionCubit)
      : super(const CreateState()) {
    otherBlocSubscription = regionCubit.stream.listen((state) {
      if (state.status == RegionStatus.success) {
        add(RegionAdded(state.regions));
      } else {
        add(const RegionAdded([]));
      }
    });
    on<RegionAdded>(_onRegionAdded);
    on<CreateEmailChanged>(_onEmailChanged);
    on<CreateFirstNameChanged>(_onFirstNameChanged);
    on<CreateLastNameChanged>(_onLastNameChanged);
    on<CreatePasswordChanged>(_onPasswordChanged);
    on<CreateSubmitted>(_onSubmitted);
    on<CreateRegionChanged>(_onRegionChanged);
  }

  final CsRepository _csRepository;
  late final StreamSubscription otherBlocSubscription;
  final RegionCubit regionCubit;

  void _onRegionAdded(RegionAdded event, Emitter<CreateState> emit) {
    final regions = event.regions
      ..insert(
        0,
        const Region(
          id: '',
          name: 'Select Region',
        ),
      );
    emit(state.copyWith(regions: regions, status: CreateStatus.initial));
  }

  void _onRegionChanged(CreateRegionChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(region: event.region, status: CreateStatus.initial));
  }

  void _onEmailChanged(CreateEmailChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(email: event.email, status: CreateStatus.initial));
  }

  void _onFirstNameChanged(
    CreateFirstNameChanged event,
    Emitter<CreateState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: event.firstName,
        status: CreateStatus.initial,
      ),
    );
  }

  void _onLastNameChanged(
    CreateLastNameChanged event,
    Emitter<CreateState> emit,
  ) {
    emit(
      state.copyWith(lastName: event.lastName, status: CreateStatus.initial),
    );
  }

  void _onPasswordChanged(
    CreatePasswordChanged event,
    Emitter<CreateState> emit,
  ) {
    emit(
      state.copyWith(password: event.password, status: CreateStatus.initial),
    );
  }

  Region getRegionWithId(String id) {
    return state.regions.firstWhere((element) => element.id == id);
  }

  Future<void> _onSubmitted(
    CreateSubmitted event,
    Emitter<CreateState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateStatus.loading));
      final response = await _csRepository.addAdmin(
        email: state.email,
        firstName: state.firstName,
        lastName: state.lastName,
        password: state.password,
        region: state.region,
      );
      final admin = Admin(
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
          status: CreateStatus.success,
          successMessage: response.message,
          admin: admin,
        ),
      );
    } on AdminFailure {
      emit(
        state.copyWith(
          status: CreateStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on AdminRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: CreateStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: CreateStatus.failure,
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
