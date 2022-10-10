part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {
  const UsersLoading();
}

class UsersError extends UsersState {
  const UsersError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class UsersSuccess extends UsersState {
  const UsersSuccess({
    required this.workers,
    required this.admins,
    required this.users,
  });

  final List<Worker> workers;
  final List<Admin> admins;
  final List<UserModel> users;

  @override
  List<Object> get props => [
        admins,
        workers,
        users,
      ];
}
