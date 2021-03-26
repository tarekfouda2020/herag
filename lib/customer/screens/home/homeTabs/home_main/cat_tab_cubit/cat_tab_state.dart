part of 'cat_tab_cubit.dart';

abstract class CatTabState extends Equatable {
  final int id;
  final bool changed;
  const CatTabState({this.id, this.changed});
}

class CatTabInitial extends CatTabState {
  CatTabInitial():super(id: 0,changed: false);
  @override
  List<Object> get props => [changed,id];
}

class CatTabUpdated extends CatTabState {
  CatTabUpdated({int id, bool changed}):super(id: id ,changed: changed);
  @override
  List<Object> get props => [changed,id];
}
