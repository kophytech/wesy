import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this.csRepository) : super(const AddNoteInitial());

  final CsRepository csRepository;
  Future<void> addNote({String? pinId, String? note}) async {
    print(pinId);
    print(note);
    try {
      emit(const AddNoteLoading());
      final response = await csRepository.addPinNote(
        pinId: pinId,
        note: note,
      );
      emit(AddNoteSuccess(response.message ?? 'Success'));
    } on PinFailure {
      emit(const AddNoteError('Something went wrong, Try again'));
    } on PinRequestFailure catch (e) {
      emit(AddNoteError(e.toString()));
    } on Exception {
      emit(const AddNoteError('Something went wrong, Try again'));
    }
  }
}
