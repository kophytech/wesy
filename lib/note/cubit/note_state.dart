part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteLoading extends NoteState {
  const NoteLoading();
}

class NoteError extends NoteState {
  const NoteError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class NoteSuccess extends NoteState {
  const NoteSuccess(this.notes);
  final List<Note> notes;

  @override
  List<Object> get props => [notes];
}
