part of 'delete_visit_cubit.dart';

abstract class DeleteVisitState extends Equatable {
  const DeleteVisitState();

  @override
  List<Object> get props => [];
}

class DeleteVisitInitial extends DeleteVisitState {
  const DeleteVisitInitial();
}

class DeleteVisitLoading extends DeleteVisitState {
  const DeleteVisitLoading();
}

class DeleteVisitFailure extends DeleteVisitState {
  const DeleteVisitFailure(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class DeleteVisitSuccess extends DeleteVisitState {
  const DeleteVisitSuccess(this.success);

  final String success;

  @override
  List<Object> get props => [success];
}
