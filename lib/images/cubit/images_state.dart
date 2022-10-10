part of 'images_cubit.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

class ImagesLoading extends ImagesState {}

class ImagesError extends ImagesState {
  const ImagesError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class ImagesSuccess extends ImagesState {
  const ImagesSuccess(this.images);

  final List<Image> images;

  @override
  List<Object> get props => [images];
}
