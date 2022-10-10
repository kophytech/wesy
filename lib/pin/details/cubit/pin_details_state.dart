part of 'pin_details_cubit.dart';

enum PinDetailsStatus {
  loading,
  success,
  failure,
}

class PinDetailsState extends Equatable {
  const PinDetailsState({
    this.status = PinDetailsStatus.loading,
    this.details,
    this.errorMessage = '',
    this.successMessage = '',
    this.selectedImageId = '',
    this.showImageIcons = false,
  });

  PinDetailsState copyWith({
    PinDetailsStatus? status,
    PinDetails? details,
    String? errorMessage,
    String? successMessage,
    bool? showImageIcons,
    String? selectedImageId,
  }) {
    return PinDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      showImageIcons: showImageIcons ?? this.showImageIcons,
      selectedImageId: selectedImageId ?? this.selectedImageId,
    );
  }

  final PinDetailsStatus status;
  final PinDetails? details;
  final String errorMessage;
  final String successMessage;
  final bool showImageIcons;
  final String selectedImageId;

  @override
  List<Object?> get props => [
        status,
        details,
        errorMessage,
        successMessage,
        showImageIcons,
        selectedImageId,
      ];
}
