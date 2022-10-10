import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit(this.csRepository) : super(ImagesLoading());

  final CsRepository csRepository;

  Future<void> getImages(String pinId) async {
    try {
      emit(ImagesLoading());
      final response = await csRepository.getImages(pinId);
      emit(ImagesSuccess(response));
    } on RouteFailure {
      emit(const ImagesError('Something went wrong, Try again'));
    } on RouteRequestFailure catch (e) {
      emit(ImagesError(e.toString()));
    }
  }
}
