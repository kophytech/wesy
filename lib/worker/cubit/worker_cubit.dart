import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'worker_state.dart';

class WorkerCubit extends Cubit<WorkerState> {
  WorkerCubit(this.csRepository) : super(const WorkerState());

  final CsRepository csRepository;

  void deleteInital() {
    emit(state.copyWith(deleteStatus: DeleteStatus.initial));
  }

  void updateWorker(Worker worker) {
    final workers = <Worker>[];
    for (final worker in state.workers) {
      workers.add(worker);
    }
    workers.add(worker);

    emit(state.copyWith(workers: workers));
  }

  Future<void> getAllWorkers() async {
    try {
      emit(state.copyWith(status: WorkerStatus.loading));
      final response = await csRepository.allWorker();
      emit(state.copyWith(status: WorkerStatus.success, workers: response));
    } on WorkerFailure {
      emit(
        state.copyWith(
          status: WorkerStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    } on WorkerRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: WorkerStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: WorkerStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> deleteWorker({String? id}) async {
    try {
      emit(state.copyWith(deleteStatus: DeleteStatus.loading));
      final response = await csRepository.deleteWorker(id: id);
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.success,
          successMessage: response.message ?? 'Deleted Successfully',
        ),
      );
    } on WorkerFailure {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on WorkerRequestFailure catch (e) {
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

  // /// Single sort, sort Name's id
  // void sortName(bool isAscending) {
  //   userInfo.sort((a, b) {
  //     final aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
  //     final bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
  //     return (aId - bId) * (isAscending ? 1 : -1);
  //   });
  // }

  // ///
  // /// sort with Status and Name as the 2nd Sort
  // void sortStatus(bool isAscending) {
  //   userInfo.sort((a, b) {
  //     if (a.status == b.status) {
  //       final aId = int.tryParse(a.name.replaceFirst('User_', '')) ?? 0;
  //       final bId = int.tryParse(b.name.replaceFirst('User_', '')) ?? 0;
  //       return aId - bId;
  //     } else if (a.status) {
  //       return isAscending ? 1 : -1;
  //     } else {
  //       return isAscending ? -1 : 1;
  //     }
  //   });
  // }
}
