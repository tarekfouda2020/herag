part of 'cats_inputs_cubit.dart';

abstract class CatsInputsState extends Equatable {
  final List<Category> cats;
  final bool changed;
  const CatsInputsState({this.cats, this.changed});
}

class CatsInputsInitial extends CatsInputsState {
  CatsInputsInitial({bool changed}) : super(cats: [],changed: changed);

  @override
  List<Object> get props => [cats,changed];
}

class CatsInputsUpdated extends CatsInputsState {
  CatsInputsUpdated({List<Category> cats, bool changed}) : super(cats: cats,changed: changed);

  @override
  List<Object> get props => [cats,changed];
}
