import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_information_state.dart';

class AddInformationCubit extends Cubit<AddInformationState> {
  AddInformationCubit(this.csRepository) : super(const AddInformationState());

  final CsRepository csRepository;

  Future<void> addInformation({
    required String pinId,
    required String info,
  }) async {
    try {
      emit(const AddInformationState(status: AddInformationStatus.loading));
      final response = await csRepository.addPinInformation(
        pinId: pinId,
        note: info,
      );
      emit(
        state.copyWith(
          status: AddInformationStatus.success,
          successMessage: response.message ?? 'Success',
        ),
      );
    } on PinFailure {
      emit(
        const AddInformationState(
          status: AddInformationStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on PinRequestFailure catch (e) {
      emit(
        AddInformationState(
          status: AddInformationStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        const AddInformationState(
          status: AddInformationStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
