import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/customer/models/UserDetailsModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/screens/user_products/ad_owner_cubit/add_owner_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_ads_state.dart';

class UserAdsCubit extends Cubit<UserAdsState> {
  UserAdsCubit() : super(UserAdsInitial());
  
  onUpdateAdsList(List<AdsModel> ads){
    emit(UserAdsUpdated(ads, !state.change));
  }
  
  fetchUserAds(BuildContext context,String userId,AddOwnerCubit addOwnerCubit,{bool refresh=true})async{
    var lang=context.read<LangCubit>().state.locale.languageCode;
    UserDetailsModel data = await CustomerRepository(context).getUserAds(userId,lang,refresh);
    onUpdateAdsList(data.ads);
    addOwnerCubit.onDataUpdated(data.userData);
  }

  setRefreshUserAds(BuildContext context,String userId,RefreshController controller,{bool refresh=true})async{
    var lang=context.read<LangCubit>().state.locale.languageCode;
    UserDetailsModel data= await CustomerRepository(context).getUserAds(userId,lang,refresh);
    onUpdateAdsList(data.ads);
    controller.refreshCompleted();
  }
  
}
