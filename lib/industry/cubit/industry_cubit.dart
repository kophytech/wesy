import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'industry_state.dart';

class IndustryCubit extends Cubit<IndustryState> {
  IndustryCubit(this.csRepository) : super(const IndustryState());

  final CsRepository csRepository;

  Future<void> getAllIndustries() async {
    try {
      emit(
        state.copyWith(
          status: IndustryStatus.loading,
          deleteStatus: DeleteStatus.initial,
        ),
      );
      final response = await csRepository.allIndustry();
      emit(
        state.copyWith(
          status: IndustryStatus.success,
          deleteStatus: DeleteStatus.initial,
          industries: response,
        ),
      );
    } on AdminFailure {
      emit(
        state.copyWith(
          status: IndustryStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    } on AdminRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: IndustryStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: IndustryStatus.failure,
          deleteStatus: DeleteStatus.initial,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> deleteIndustry({String? pinId}) async {
    try {
      emit(state.copyWith(deleteStatus: DeleteStatus.loading));
      final response = await csRepository.deleteIndustry(pinId: pinId);
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.success,
          successMessage: response.message ?? 'Deleted Successfully',
        ),
      );
    } on RouteFailure {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on RouteRequestFailure catch (e) {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    }
  }
}
