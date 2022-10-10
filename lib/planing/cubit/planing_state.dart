part of 'planing_cubit.dart';

enum PlaningStatus {
  initial,
  loading,
  failure,
  success,
}

class PlaningState extends Equatable {
  const PlaningState({
    this.status = PlaningStatus.initial,
    this.admins = const [],
    this.workers = const [],
    this.errorMessage = '',
  });

  PlaningState copyWith({
    PlaningStatus? status,
    String? errorMessage,
    List<Worker>? workers,
    List<Admin>? admins,
  }) {
    return PlaningState(
      status: status ?? this.status,
      workers: workers ?? this.workers,
      admins: admins ?? this.admins,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  final PlaningStatus status;
  final List<Worker> workers;
  final List<Admin> admins;
  final String errorMessage;

  @override
  List<Object> get props => [status, errorMessage, workers, admins];
}
