part of 'information_cubit.dart';

abstract class InformationState extends Equatable {
  const InformationState();

  @override
  List<Object> get props => [];
}

class InformationLoading extends InformationState {
  const InformationLoading();
}

class InformationError extends InformationState {
  const InformationError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class InformationSuccess extends InformationState {
  const InformationSuccess(this.note);

  final ImportantNote note;

  @override
  List<Object> get props => [note];
}
