import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit(this.csRepository) : super(const DeleteNoteInitial());

  CsRepository csRepository;

  Future<void> deleteNote({
    required String noteId,
    required String pinId,
  }) async {
    try {
      emit(const DeleteNoteLoading());
      final response = await csRepository.deletePinNote(
        noteId: noteId,
        pinId: pinId,
      );
      emit(DeleteNoteSuccess(response.message ?? 'Success'));
    } on PinRequestFailure catch (e) {
      emit(DeleteNoteError(e.toString()));
    } on Exception {
      emit(const DeleteNoteError('Something went wrong, Try again'));
    }
  }
}
