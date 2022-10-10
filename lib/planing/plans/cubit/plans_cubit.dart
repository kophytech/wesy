import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit({required CsRepository csRepository})
      : _csRepository = csRepository,
        super(const PlansState());

  final CsRepository _csRepository;

  void deviceTokenUpdated(String token) {
    emit(state.copyWith(deviceToken: token));
  }

  void updateSchedule(Schedule newSchedule) {
    final availableSchedules = <Schedule>[];

    for (final schedule in state.schedules) {
      availableSchedules.add(schedule);
    }
    availableSchedules.add(newSchedule);
    emit(state.copyWith(schedules: availableSchedules));
  }

  void onDataChanged({
    required String startDate,
    required String endDate,
    required String note,
    required String title,
  }) {
    emit(
      state.copyWith(
        startDate: startDate,
        endDate: endDate,
        note: note,
        title: title,
        planStatus: PlanStatus.initial,
      ),
    );
  }

  Future<void> getSchedules() async {
    try {
      emit(state.copyWith(getPlanStatus: GetPlanStatus.loading));
      final response = await _csRepository.getSchedules();
      emit(
        state.copyWith(
          getPlanStatus: GetPlanStatus.success,
          schedules: response,
        ),
      );
    } on PlanRequestFailure catch (e) {
      emit(
        state.copyWith(
          getPlanStatus: GetPlanStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on PlanFailure {
      emit(
        state.copyWith(
          getPlanStatus: GetPlanStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          getPlanStatus: GetPlanStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    }
  }

  Future<void> createPlan() async {
    try {
      emit(state.copyWith(planStatus: PlanStatus.loading));
      final response = await _csRepository.addPlan(
        startDate: state.startDate,
        endDate: state.endDate,
        allDay: state.allDay,
        note: state.note,
        title: state.title,
        deviceToken: state.deviceToken,
      );
      emit(
        state.copyWith(
          planStatus: PlanStatus.success,
          successMessage: response.message,
        ),
      );
    } on PlanRequestFailure catch (e) {
      emit(
        state.copyWith(
          planStatus: PlanStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on PlanFailure {
      emit(
        state.copyWith(
          planStatus: PlanStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          planStatus: PlanStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    }
  }
}
