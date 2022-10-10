part of 'add_image_cubit.dart';

abstract class AddImageState extends Equatable {
  const AddImageState();

  @override
  List<Object> get props => [];
}

class AddImageInitial extends AddImageState {}

class AddImageLoading extends AddImageState {
  const AddImageLoading();
}

class AddImageError extends AddImageState {
  const AddImageError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class AddImageSuccess extends AddImageState {
  const AddImageSuccess(this.success);

  final String success;

  @override
  List<Object> get props => [success];
}
