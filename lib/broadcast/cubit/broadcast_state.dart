part of 'broadcast_cubit.dart';

enum BroadcastStatus {
  initial,
  loading,
  error,
  success,
}

class BroadcastState extends Equatable {
  const BroadcastState({
    this.errorMessage = '',
    this.successMessage = '',
    this.recipients = const [],
    this.title = '',
    this.startDate = '',
    this.endDate = '',
    this.note = '',
    this.status = BroadcastStatus.initial,
    this.buttonEnabled = false,
  });

  BroadcastState copyWith({
    String? errorMessage,
    String? successMessage,
    List<String>? recipients,
    String? title,
    String? startDate,
    String? endDate,
    String? note,
    BroadcastStatus? status,
    bool? buttonEnabled,
  }) {
    return BroadcastState(
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      recipients: recipients ?? this.recipients,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      note: note ?? this.note,
      status: status ?? this.status,
      buttonEnabled: buttonEnabled ?? this.buttonEnabled,
    );
  }

  final String errorMessage;
  final String successMessage;
  final List<String> recipients;
  final String title;
  final String startDate;
  final String endDate;
  final String note;
  final BroadcastStatus status;
  final bool buttonEnabled;

  @override
  List<Object> get props => [
        errorMessage,
        successMessage,
        recipients,
        title,
        startDate,
        endDate,
        note,
        status,
        buttonEnabled,
      ];
}
