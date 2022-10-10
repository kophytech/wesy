import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this.csRepository) : super(const AdminState());

  final CsRepository csRepository;

  void deleteInital() {
    emit(state.copyWith(deleteStatus: DeleteStatus.initial));
  }

  void updateAdmin(Admin admin) {
    final admins = <Admin>[];
    for (final admin in state.admins) {
      admins.add(admin);
    }
    admins.add(admin);

    emit(state.copyWith(admins: admins));
  }

  Future<void> getAllAdmins() async {
    try {
      emit(state.copyWith(status: AdminStatus.loading));
      final response = await csRepository.allAdmin();
      emit(
        state.copyWith(
          status: AdminStatus.success,
          admins: response,
        ),
      );
    } on AdminFailure {
      emit(
        state.copyWith(
          status: AdminStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    } on AdminRequestFailure catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: AdminStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> deleteAdmin({String? id}) async {
    try {
      emit(state.copyWith(deleteStatus: DeleteStatus.loading));
      final response = await csRepository.deleteAdmin(id: id);
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.success,
          successMessage: response.message ?? 'Deleted Successfully',
        ),
      );
    } on AdminFailure {
      emit(
        state.copyWith(
          deleteStatus: DeleteStatus.failure,
          errorMessage: 'Something went wrong, Try again',
        ),
      );
    } on AdminRequestFailure catch (e) {
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
