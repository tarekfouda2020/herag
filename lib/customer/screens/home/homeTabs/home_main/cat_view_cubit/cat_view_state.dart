part of 'cat_view_cubit.dart';

abstract class CatViewState extends Equatable {
  final List<CategoryChildModel> catRows;
  final bool changed;
  const CatViewState({this.catRows, this.changed});
  @override
  // TODO: implement props
  List<Object> get props => [catRows];
}

class CatViewInitial extends CatViewState {
  CatViewInitial() : super(catRows: [],changed: false);

  @override
  List<Object> get props => [catRows,changed];
}

class CatViewUpdateState extends CatViewState {
  CatViewUpdateState({List<CategoryChildModel> catRows, bool changed}) : super(catRows: catRows,changed: changed);

  @override
  List<Object> get props => [catRows,changed];
}


