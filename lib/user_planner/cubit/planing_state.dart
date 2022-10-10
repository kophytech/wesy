part of 'planing_cubit.dart';

enum PlanningStatus {
  initial,
  loading,
  success,
  failure,
}

enum GetPlanningStatus {
  initial,
  loading,
  success,
  failure,
}

class PlaningState extends Equatable {
  const PlaningState({
    this.planStatus = PlanningStatus.initial,
    this.startDate = '',
    this.endDate = '',
    this.allDay = true,
    this.title = '',
    this.note = '',
    this.errorMessage = '',
    this.successMessage = '',
    this.deviceToken = '',
    this.schedules = const [],
    this.getPlanStatus = GetPlanningStatus.loading,
    this.userId = '',
  });

  PlaningState copyWith({
    PlanningStatus? planStatus,
    String? startDate,
    String? endDate,
    bool? allDay,
    String? title,
    String? note,
    String? errorMessage,
    String? successMessage,
    String? deviceToken,
    List<Schedule>? schedules,
    String? userId,
    GetPlanningStatus? getPlanStatus,
  }) {
    return PlaningState(
      planStatus: planStatus ?? this.planStatus,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      allDay: allDay ?? this.allDay,
      title: title ?? this.title,
      note: note ?? this.note,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      deviceToken: deviceToken ?? this.deviceToken,
      schedules: schedules ?? this.schedules,
      getPlanStatus: getPlanStatus ?? this.getPlanStatus,
      userId: userId ?? this.userId,
    );
  }

  final PlanningStatus planStatus;
  final String startDate;
  final String endDate;
  final bool allDay;
  final String title;
  final String note;
  final String errorMessage;
  final String successMessage;
  final String deviceToken;
  final List<Schedule> schedules;
  final String userId;
  final GetPlanningStatus getPlanStatus;

  @override
  List<Object> get props => [
        planStatus,
        startDate,
        endDate,
        allDay,
        title,
        note,
        errorMessage,
        schedules,
        successMessage,
        deviceToken,
        getPlanStatus,
        userId,
      ];
}
