import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/AdsDetailsModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/screens/product_comments/comment_cubit/comment_cubit.dart';
import 'package:base_flutter/customer/screens/product_details/favourite_cubit/favourite_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  onModelUpdated(AdsDetailsModel model,FavouriteCubit favouriteCubit,CommentCubit commentCubit,){
    commentCubit.onSetCommentsList(model.adsData.comments);
    favouriteCubit.onUpdateFav(
        count: model.adsData.countFavorite,
        fav: model.adsData.checkWishList,
        follow: model.adsData.checkFollows
    );
    emit(ProductDetailsUpdated(model, !state.change));
  }

  fetchAdsDetails(BuildContext context,int id,FavouriteCubit favouriteCubit,CommentCubit commentCubit, {bool refresh=true})async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    AdsDetailsModel detailsModel = await CustomerRepository(context).getAdDetails("$id",lang,refresh);
    onModelUpdated(detailsModel,favouriteCubit,commentCubit);
  }

}
