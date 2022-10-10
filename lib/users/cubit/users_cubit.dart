import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:wesy/users/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this.csRepository) : super(const UsersLoading());

  final CsRepository csRepository;

  Future<void> getUsers(int role) async {
    try {
      emit(const UsersLoading());
      if (role == 3) {
        final workers = await csRepository.allWorker();
        final admins = await csRepository.allAdmin();
        final users = <UserModel>[];
        for (final worker in workers) {
          users.add(
            UserModel(
              fullName: '${worker.firstName} ${worker.lastName}',
              userId: worker.id,
            ),
          );
        }
        for (final admin in admins) {
          users.add(
            UserModel(
              fullName: '${admin.firstName} ${admin.lastName}',
              userId: admin.id,
            ),
          );
        }
        emit(
          UsersSuccess(
            workers: workers,
            admins: admins,
            users: users,
          ),
        );
      } else {
        final workers = await csRepository.allWorker();
        final users = <UserModel>[];
        for (final element in workers) {
          users.add(
            UserModel(
              fullName: '${element.firstName} ${element.lastName}',
              userId: element.id,
            ),
          );
        }
        emit(
          UsersSuccess(
            workers: workers,
            admins: const [],
            users: users,
          ),
        );
      }
    } on PlanRequestFailure catch (e) {
      emit(UsersError(e.toString()));
    } on PlanFailure {
      emit(const UsersError('An error occur, Try again later'));
    } on Exception {
      emit(const UsersError('An error occur, Try again later'));
    }
  }
}
