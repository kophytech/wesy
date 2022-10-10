import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'visit_state.dart';

class VisitCubit extends Cubit<VisitState> {
  VisitCubit(this.csRepository) : super(const VisitLoading());

  final CsRepository csRepository;

  Future<void> getVisits(String pinId) async {
    try {
      emit(const VisitLoading());
      final response = await csRepository.getVisits(pinId);
      emit(VisitSuccess(response));
    } on RouteFailure {
      emit(const VisitError('Something went wrong, Try again'));
    } on RouteRequestFailure catch (e) {
      emit(VisitError(e.toString()));
    }
  }
}
