part of 'worker_cubit.dart';

enum WorkerStatus { loading, success, failure }

enum DeleteStatus { initial, loading, success, failure }

class WorkerState extends Equatable {
  const WorkerState({
    this.status = WorkerStatus.loading,
    this.workers = const [],
    this.errorMessage = '',
    this.successMessage = '',
    this.deleteStatus = DeleteStatus.initial,
  });

  WorkerState copyWith({
    WorkerStatus? status,
    List<Worker>? workers,
    String? errorMessage,
    DeleteStatus? deleteStatus,
    String? successMessage,
  }) {
    return WorkerState(
      status: status ?? this.status,
      workers: workers ?? this.workers,
      errorMessage: errorMessage ?? this.errorMessage,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  final WorkerStatus status;
  final List<Worker> workers;
  final String errorMessage;
  final String successMessage;
  final DeleteStatus deleteStatus;

  @override
  List<Object> get props =>
      [status, workers, errorMessage, successMessage, deleteStatus];
}
