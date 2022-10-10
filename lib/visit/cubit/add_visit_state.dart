part of 'add_visit_cubit.dart';

abstract class AddVisitState extends Equatable {
  const AddVisitState();

  @override
  List<Object> get props => [];
}

class AddVisitInitial extends AddVisitState {
  const AddVisitInitial();
}

class AddVisitLoading extends AddVisitState {
  const AddVisitLoading();
}

class AddVisitFailure extends AddVisitState {
  const AddVisitFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class AddVisitSuccess extends AddVisitState {
  const AddVisitSuccess(this.success);

  final String success;

  @override
  List<Object> get props => [success];
}
