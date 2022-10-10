import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'pin_details_state.dart';

class PinDetailsCubit extends Cubit<PinDetailsState> {
  PinDetailsCubit(this.csRepository) : super(const PinDetailsState());

  final CsRepository csRepository;
  final ImagePicker _picker = ImagePicker();

  void imageIconChanged(bool value, String selectedImageId) {
    emit(
      state.copyWith(
        showImageIcons: value,
        selectedImageId: selectedImageId,
      ),
    );
  }

  Future<void> getPinDetails({String? pinId}) async {
    try {
      emit(
        state.copyWith(
          status: PinDetailsStatus.loading,
        ),
      );
      final response = await csRepository.getPinDetails(pinId: pinId);
      emit(
        state.copyWith(
          status: PinDetailsStatus.success,
          details: response,
        ),
      );
    } on PinFailure {
      emit(
        state.copyWith(
          status: PinDetailsStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on PinRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: PinDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: PinDetailsStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }

  Future<List<XFile>?> uploadCameraImage(String pinId) async {
    final availableImages = <XFile>[];
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      availableImages.add(pickedImage);
      return availableImages;
    }
    return null;
  }

  Future<List<XFile>?> uploadMultiImage() async {
    final pickedImage = await _picker.pickMultiImage();
    if (pickedImage != null) {
      return pickedImage;
    }
    return null;
  }
}
