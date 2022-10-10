part of 'visit_cubit.dart';

abstract class VisitState extends Equatable {
  const VisitState();

  @override
  List<Object> get props => [];
}

class VisitLoading extends VisitState {
  const VisitLoading();
}

class VisitError extends VisitState {
  const VisitError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

class VisitSuccess extends VisitState {
  const VisitSuccess(this.visits);
  final List<Visit> visits;

  @override
  List<Object> get props => [visits];
}
