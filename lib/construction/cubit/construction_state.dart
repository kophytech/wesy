part of 'construction_cubit.dart';

enum ConstructionStatus { loading, success, failure }

enum DeleteStatus { initial, loading, success, failure }

class ConstructionState extends Equatable {
  const ConstructionState({
    this.status = ConstructionStatus.loading,
    this.constructions = const [],
    this.errorMessage = '',
    this.successMessage = '',
    this.deleteStatus = DeleteStatus.loading,
  });

  ConstructionState copyWith({
    ConstructionStatus? status,
    List<Construction>? constructions,
    String? errorMessage,
    DeleteStatus? deleteStatus,
    String? successMessage,
  }) {
    return ConstructionState(
      status: status ?? this.status,
      constructions: constructions ?? this.constructions,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  final ConstructionStatus status;
  final List<Construction> constructions;
  final String errorMessage;
  final String successMessage;
  final DeleteStatus deleteStatus;

  @override
  List<Object> get props =>
      [status, constructions, errorMessage, deleteStatus, successMessage];
}
