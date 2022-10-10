part of 'delete_note_cubit.dart';

abstract class DeleteNoteState extends Equatable {
  const DeleteNoteState();

  @override
  List<Object> get props => [];
}

class DeleteNoteInitial extends DeleteNoteState {
  const DeleteNoteInitial();
}

class DeleteNoteLoading extends DeleteNoteState {
  const DeleteNoteLoading();
}

class DeleteNoteError extends DeleteNoteState {
  const DeleteNoteError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class DeleteNoteSuccess extends DeleteNoteState {
  const DeleteNoteSuccess(this.success);
  final String success;

  @override
  List<Object> get props => [success];
}
