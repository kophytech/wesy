import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'construction_state.dart';

class ConstructionCubit extends Cubit<ConstructionState> {
  ConstructionCubit(this.csRepository) : super(const ConstructionState());

  final CsRepository csRepository;

  Future<void> getAllConstructions() async {
    try {
      emit(
        state.copyWith(
          status: ConstructionStatus.loading,
          deleteStatus: DeleteStatus.initial,
        ),
      );
      final response = await csRepository.allConstruction();
      emit(
        state.copyWith(
          status: ConstructionStatus.success,
          deleteStatus: DeleteStatus.initial,
          constructions: response,
        ),
      );
    } on AdminFailure {
      emit(
        state.copyWith(
          status: ConstructionStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    } on AdminRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: ConstructionStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: ConstructionStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> deleteConstruction({String? pinId}) async {
    try {
      emit(state.copyWith(deleteStatus: DeleteStatus.loading));
      final response = await csRepository.deleteConstruction(pinId: pinId);
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.success,
          successMessage: response.message,
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
