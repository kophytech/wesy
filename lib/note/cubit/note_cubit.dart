import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this.csRepository) : super(const NoteLoading());

  final CsRepository csRepository;

  Future<void> getNotes(String pinId) async {
    try {
      emit(const NoteLoading());
      final response = await csRepository.getNotes(pinId);
      emit(NoteSuccess(response));
    } on RouteFailure {
      emit(const NoteError('Something went wrong, Try again'));
    } on RouteRequestFailure catch (e) {
      emit(NoteError(e.toString()));
    } catch (e) {
      emit(const NoteError(''));
    }
  }
}
