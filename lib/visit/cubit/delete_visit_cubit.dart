import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'delete_visit_state.dart';

class DeleteVisitCubit extends Cubit<DeleteVisitState> {
  DeleteVisitCubit(this.csRepository) : super(const DeleteVisitInitial());

  CsRepository csRepository;

  Future<void> deleteVisit({
    required String visitId,
    required String pinId,
  }) async {
    try {
      emit(const DeleteVisitLoading());
      final response = await csRepository.deletePinVisit(
        visitId: visitId,
        pinId: pinId,
      );
      emit(DeleteVisitSuccess(response.message ?? 'Success'));
    } on PinRequestFailure catch (e) {
      emit(DeleteVisitFailure(e.toString()));
    } on Exception {
      emit(const DeleteVisitFailure('Something went wrong, Try again'));
    }
  }
}
