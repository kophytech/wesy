import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'add_image_state.dart';

class AddImageCubit extends Cubit<AddImageState> {
  AddImageCubit(this.csRepository) : super(AddImageInitial());

  final CsRepository csRepository;

  Future<void> addImages({
    required String pinId,
    required List<XFile> images,
  }) async {
    try {
      print(images.length);
      emit(const AddImageLoading());
      final newImages = <File>[];
      for (final image in images) {
        newImages.add(File(image.path));
      }
      final response = await csRepository.uploadImage(
        pinId: pinId,
        images: newImages,
      );
      emit(AddImageSuccess(response.message ?? 'Success'));
    } on PinFailure {
      emit(const AddImageError('Something went wrong, Try again'));
    } on PinRequestFailure catch (e) {
      emit(AddImageError(e.toString()));
    } on Exception {
      emit(const AddImageError('Something went wrong, Try again'));
    }
  }
}
