part of 'industry_cubit.dart';

enum IndustryStatus { loading, success, failure }

enum DeleteStatus { initial, loading, success, failure }

class IndustryState extends Equatable {
  const IndustryState({
    this.status = IndustryStatus.loading,
    this.industries = const [],
    this.errorMessage = '',
    this.successMessage = '',
    this.deleteStatus = DeleteStatus.initial,
  });

  IndustryState copyWith({
    IndustryStatus? status,
    List<Industry>? industries,
    String? errorMessage,
    String? successMessage,
    DeleteStatus? deleteStatus,
  }) {
    return IndustryState(
      status: status ?? this.status,
      industries: industries ?? this.industries,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  final IndustryStatus status;
  final List<Industry> industries;
  final String errorMessage;
  final String successMessage;
  final DeleteStatus deleteStatus;

  @override
  List<Object> get props => [
        status,
        industries,
        errorMessage,
        successMessage,
        deleteStatus,
      ];
}
