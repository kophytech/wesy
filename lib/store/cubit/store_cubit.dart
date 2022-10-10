import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this.csRepository) : super(const StoreState());

  final CsRepository csRepository;

  Future<void> getAllStores() async {
    try {
      emit(
        state.copyWith(
          status: StoreStatus.loading,
          deleteStatus: DeleteStatus.initial,
        ),
      );
      final response = await csRepository.allStore();
      emit(
        state.copyWith(
          status: StoreStatus.success,
          deleteStatus: DeleteStatus.initial,
          stores: response,
        ),
      );
    } on AdminFailure {
      emit(
        state.copyWith(
          status: StoreStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    } on AdminRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: StoreStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: StoreStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> deleteStore({String? pinId}) async {
    try {
      emit(state.copyWith(deleteStatus: DeleteStatus.loading));
      final response = await csRepository.deleteStore(pinId: pinId);
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.success,
          successMessage: response.message ?? 'Deleted Successfully',
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
