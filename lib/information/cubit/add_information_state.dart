part of 'add_information_cubit.dart';

enum AddInformationStatus {
  initial,
  loading,
  failure,
  success,
}

class AddInformationState extends Equatable {
  const AddInformationState({
    this.status = AddInformationStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
  });

  AddInformationState copyWith({
    AddInformationStatus? status,
    String? errorMessage,
    String? successMessage,
  }) =>
      AddInformationState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
      );

  final AddInformationStatus status;
  final String errorMessage;
  final String successMessage;

  @override
  List<Object> get props => [
        status,
        errorMessage,
        successMessage,
      ];
}
