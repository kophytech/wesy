part of 'delete_image_cubit.dart';

abstract class DeleteImageState extends Equatable {
  const DeleteImageState();

  @override
  List<Object> get props => [];
}

class DeleteImageInitial extends DeleteImageState {
  const DeleteImageInitial();
}

class DeleteImageLoading extends DeleteImageState {
  const DeleteImageLoading();
}

class DeleteImageError extends DeleteImageState {
  const DeleteImageError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class DeleteImageSuccess extends DeleteImageState {
  const DeleteImageSuccess(this.success);
  final String success;

  @override
  List<Object> get props => [success];
}
