import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_views_state.dart';

class ProductViewsCubit extends Cubit<ProductViewsState> {
  ProductViewsCubit() : super(ProductViewsInitial());

  setChangeView({bool showGrid}){
    emit(ProductViewsChanged(showGrid));
  }
}
