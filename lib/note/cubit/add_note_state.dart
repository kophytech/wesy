part of 'add_note_cubit.dart';

abstract class AddNoteState extends Equatable {
  const AddNoteState();

  @override
  List<Object> get props => [];
}

class AddNoteInitial extends AddNoteState {
  const AddNoteInitial();
}

class AddNoteLoading extends AddNoteState {
  const AddNoteLoading();
}

class AddNoteError extends AddNoteState {
  const AddNoteError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class AddNoteSuccess extends AddNoteState {
  const AddNoteSuccess(this.success);

  final String success;

  @override
  List<Object> get props => [success];
}
