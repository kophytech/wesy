import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'planing_state.dart';

class PlaningCubit extends Cubit<PlaningState> {
  PlaningCubit({required CsRepository csRepository})
      : _csRepository = csRepository,
        super(const PlaningState());

  final CsRepository _csRepository;

  void deviceTokenUpdated(String token) {
    emit(state.copyWith(deviceToken: token));
  }

  void updateUserId(String userId) {
    emit(state.copyWith(userId: userId));
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
        planStatus: PlanningStatus.initial,
      ),
    );
  }

  Future<void> getSchedules() async {
    try {
      emit(state.copyWith(getPlanStatus: GetPlanningStatus.loading));
      final response = await _csRepository.getUserSchedules(state.userId);
      emit(
        state.copyWith(
          getPlanStatus: GetPlanningStatus.success,
          schedules: response,
        ),
      );
    } on PlanRequestFailure catch (e) {
      emit(
        state.copyWith(
          getPlanStatus: GetPlanningStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on PlanFailure {
      emit(
        state.copyWith(
          getPlanStatus: GetPlanningStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          getPlanStatus: GetPlanningStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    }
  }

  Future<void> createPlan() async {
    try {
      emit(state.copyWith(planStatus: PlanningStatus.loading));
      final response = await _csRepository.addUserPlan(
        startDate: state.startDate,
        endDate: state.endDate,
        allDay: state.allDay,
        note: state.note,
        title: state.title,
        userId: state.userId,
        deviceToken: state.deviceToken,
      );
      emit(
        state.copyWith(
          planStatus: PlanningStatus.success,
          successMessage: response.message,
        ),
      );
    } on PlanRequestFailure catch (e) {
      emit(
        state.copyWith(
          planStatus: PlanningStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on PlanFailure {
      emit(
        state.copyWith(
          planStatus: PlanningStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          planStatus: PlanningStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    }
  }
}
