import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'delete_image_state.dart';

class DeleteImageCubit extends Cubit<DeleteImageState> {
  DeleteImageCubit(this.csRepository) : super(const DeleteImageInitial());

  final CsRepository csRepository;

  Future<void> deleteImage({
    required String imageId,
    required String pinId,
  }) async {
    try {
      emit(const DeleteImageLoading());
      final response = await csRepository.deletePinImage(
        pinId: pinId,
        imageId: imageId,
      );
      emit(DeleteImageSuccess(response.message ?? 'Success'));
    } on PinRequestFailure catch (e) {
      emit(DeleteImageError(e.toString()));
    } on Exception {
      emit(const DeleteImageError('Something went wrong, Try again'));
    }
  }
}
