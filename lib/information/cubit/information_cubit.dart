import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'information_state.dart';

class InformationCubit extends Cubit<InformationState> {
  InformationCubit(this.csRepository) : super(const InformationLoading());

  final CsRepository csRepository;

  Future<void> getInformation(String pinId) async {
    try {
      emit(const InformationLoading());
      final response = await csRepository.getImportantNotes(pinId);
      emit(InformationSuccess(response));
    } on RouteFailure {
      emit(const InformationError('Something went wrong, Try again'));
    } on RouteRequestFailure catch (e) {
      emit(InformationError(e.toString()));
    }
  }
}
