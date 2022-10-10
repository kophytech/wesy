import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'planing_state.dart';

class PlaningCubit extends Cubit<PlaningState> {
  PlaningCubit({required this.csRepository}) : super(const PlaningState());

  final CsRepository csRepository;

  void updateStatusToInitial() {
    emit(state.copyWith(status: PlaningStatus.initial));
  }

  Future<void> getUsers(int role) async {
    try {
      emit(state.copyWith(status: PlaningStatus.loading));

      if (role == 3) {
        final workers = await csRepository.allWorker();
        final admins = await csRepository.allAdmin();
        emit(
          state.copyWith(
            status: PlaningStatus.success,
            workers: workers,
            admins: admins,
          ),
        );
      } else {
        final workers = await csRepository.allWorker();
        emit(
          state.copyWith(
            status: PlaningStatus.success,
            workers: workers,
            admins: [],
          ),
        );
      }
    } on PlanRequestFailure {
      emit(
        state.copyWith(
          status: PlaningStatus.failure,
          // errorMessage: e.toString(),
        ),
      );
    } on PlanFailure {
      emit(
        state.copyWith(
          status: PlaningStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: PlaningStatus.failure,
          errorMessage: 'An error occur, Try again later',
        ),
      );
    }
  }
}
