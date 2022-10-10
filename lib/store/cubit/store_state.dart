part of 'store_cubit.dart';

enum StoreStatus { loading, success, failure }

enum DeleteStatus { initial, loading, success, failure }

class StoreState extends Equatable {
  const StoreState({
    this.status = StoreStatus.loading,
    this.deleteStatus = DeleteStatus.initial,
    this.stores = const [],
    this.errorMessage = '',
    this.successMessage = '',
  });

  StoreState copyWith({
    StoreStatus? status,
    List<Construction>? stores,
    String? errorMessage,
    DeleteStatus? deleteStatus,
    String? successMessage,
  }) {
    return StoreState(
      status: status ?? this.status,
      stores: stores ?? this.stores,
      errorMessage: errorMessage ?? this.errorMessage,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  final StoreStatus status;
  final List<Construction> stores;
  final String errorMessage;
  final DeleteStatus deleteStatus;
  final String successMessage;

  @override
  List<Object> get props => [
        status,
        stores,
        errorMessage,
        deleteStatus,
        successMessage,
      ];
}
