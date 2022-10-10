import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_visit_state.dart';

class AddVisitCubit extends Cubit<AddVisitState> {
  AddVisitCubit(this.csRepository) : super(const AddVisitInitial());

  final CsRepository csRepository;

  Future<void> addVisit({
    String? pinId,
    String? visitDate,
    String? visitNote,
  }) async {
    try {
      emit(const AddVisitLoading());
      final response = await csRepository.addPinVisit(
        pinId: pinId,
        date: visitDate,
        note: visitNote,
      );
      emit(AddVisitSuccess(response.message ?? 'Success'));
    } on PinFailure {
      emit(const AddVisitFailure('Something went wrong, Try again'));
    } on PinRequestFailure catch (e) {
      emit(AddVisitFailure(e.toString()));
    } on Exception {
      emit(const AddVisitFailure('Something went wrong, Try again'));
    }
  }
}
