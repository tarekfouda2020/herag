part of 'product_views_cubit.dart';

abstract class ProductViewsState extends Equatable {
  final bool showGrid;
  const ProductViewsState(this.showGrid);
}

class ProductViewsInitial extends ProductViewsState {
  ProductViewsInitial() : super(false);

  @override
  List<Object> get props => [showGrid];
}

class ProductViewsChanged extends ProductViewsState {
  ProductViewsChanged(bool showGrid) : super(showGrid);

  @override
  List<Object> get props => [showGrid];
}
