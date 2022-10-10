part of 'plans_cubit.dart';

enum PlanStatus {
  initial,
  loading,
  success,
  failure,
}

enum GetPlanStatus {
  initial,
  loading,
  success,
  failure,
}

class PlansState extends Equatable {
  const PlansState({
    this.planStatus = PlanStatus.initial,
    this.startDate = '',
    this.endDate = '',
    this.allDay = false,
    this.title = '',
    this.note = '',
    this.errorMessage = '',
    this.successMessage = '',
    this.deviceToken = '',
    this.schedules = const [],
    this.getPlanStatus = GetPlanStatus.loading,
  });

  PlansState copyWith({
    PlanStatus? planStatus,
    String? startDate,
    String? endDate,
    bool? allDay,
    String? title,
    String? note,
    String? errorMessage,
    String? successMessage,
    String? deviceToken,
    List<Schedule>? schedules,
    GetPlanStatus? getPlanStatus,
  }) {
    return PlansState(
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
    );
  }

  final PlanStatus planStatus;
  final String startDate;
  final String endDate;
  final bool allDay;
  final String title;
  final String note;
  final String errorMessage;
  final String successMessage;
  final String deviceToken;
  final List<Schedule> schedules;
  final GetPlanStatus getPlanStatus;

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
      ];
}
