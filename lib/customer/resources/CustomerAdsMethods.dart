import 'package:base_flutter/general/blocs/chat_count_cubit/chat_count_cubit.dart';
import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:base_flutter/general/blocs/notify_count_cubit/notify_count_cubit.dart';
import 'package:base_flutter/general/blocs/show_pay-cubit/show_pay_cubit.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/AdOwnerModel.dart';
import 'package:base_flutter/customer/models/AdsDetailsModel.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/customer/models/BankModel.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/customer/models/DropDownModel.dart';
import 'package:base_flutter/customer/models/Dtos/AddAdsModel.dart';
import 'package:base_flutter/customer/models/Dtos/AddPayModel.dart';
import 'package:base_flutter/customer/models/Dtos/FilterModel.dart';
import 'package:base_flutter/customer/models/Dtos/UpdateAdModel.dart';
import 'package:base_flutter/customer/models/EditAdModel.dart';
import 'package:base_flutter/customer/models/NotifyModel.dart';
import 'package:base_flutter/customer/models/OffersHeaderModel.dart';
import 'package:base_flutter/customer/models/ReplyModel.dart';
import 'package:base_flutter/customer/models/SearchModel.dart';
import 'package:base_flutter/customer/models/SpecificationHeaderModel.dart';
import 'package:base_flutter/customer/models/UserDetailsModel.dart';
import 'package:base_flutter/customer/models/UserFollowerModel.dart';
import 'package:base_flutter/general/constants/GlobalState.dart';
import 'package:base_flutter/general/models/UserModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/general/utilities/dio_helper/DioImports.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';

class CustomerAdsMethods{
  final BuildContext context;

  CustomerAdsMethods(this.context);

  Future<List<AdsModel>> getAdsData(FilterModel model,bool refresh)async{
    model.lang=context.read<LangCubit>().state.locale.languageCode;
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListAllAdsByFillter", model.toJson());
    if(_data!=null){
      context.read<ShowPayCubit>().onUpdateShow(_data["showPay"]??true);
      context.read<NotifyCountCubit>().onUpdateCount(_data["countNotify"]??0);
      context.read<ChatCountCubit>().onUpdateCount(_data["countChat"]);
      return List<AdsModel>.from(_data["data"].map((e) => AdsModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<List<DropDownModel>> getRegionData()async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang
    };
    var _data = await DioHelper(forceRefresh: false).get("/api/v1/ListOfRegoinAsync", body);
    if(_data!=null){
      return List<DropDownModel>.from(_data["data"].map((e) => DropDownModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<List<DropDownModel>> getCitiesData(String regionId)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "regoinId":regionId
    };
    var _data = await DioHelper(forceRefresh: false).get("/api/v1/ListOfCitysAsync", body);
    if(_data!=null){
      return List<DropDownModel>.from(_data["data"].map((e) => DropDownModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<List<DropDownModel>> getNeighborsData(String cityId)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "cityId":cityId
    };
    var _data = await DioHelper(forceRefresh: false).get("/api/v1/ListOfDistrictsByCityIdAsync", body);
    if(_data!=null){
      return List<DropDownModel>.from(_data["data"].map((e) => DropDownModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<List<OffersHeaderModel>> getOffersHeaderData(bool refresh)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang
    };
    print(body);
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListOfHeaderAds", body);
    if(_data!=null){
      return List<OffersHeaderModel>.from(_data["data"].map((e) => OffersHeaderModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<List<SpecificationHeaderModel>> getOffersPropertyData(String catId)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "catId":catId,
    };
    print(body);
    var _data = await DioHelper(forceRefresh: false).get("/api/v1/ListOfSpecifications", body);
    if(_data!=null){
      return List<SpecificationHeaderModel>.from(_data["data"].map((e) => SpecificationHeaderModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<bool> setAddOffer(AddAdsModel model)async{
    var _data = await DioHelper().uploadFile("/api/v1/Add_AdsForAppAsync", model.toJson());
    return _data!=null?true:false;
  }

  Future<bool> setEditOffer(UpdateAdModel model)async{
    var _data = await DioHelper().uploadFile("/api/v1/Update_AdsForAppAsync", model.toJson());
    return _data!=null?true:false;
  }

  Future<AdsDetailsModel> getAdDetails(String adsId,String lang,bool refresh)async{
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":adsId,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/GetAdsInfo", body);
    if(_data!=null){
      return AdsDetailsModel.fromMap(_data["data"]);
    }else{
      return null;
    }
  }

  Future<List<CommentModel>> getAdComments(String adsId,String lang,bool refresh)async{
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":adsId,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/GetAdsCommentInfo", body);
    if(_data!=null){
      return List<CommentModel>.from(_data["data"].map((e) => CommentModel.fromMap(e)));
    }else{
      return [];
    }
  }

  Future<CommentModel> addAdComments(String adsId,String comment)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":adsId,
      "comment":comment
    };
    var _data = await DioHelper().post("/api/v1/AddCommentToAdsAsync", body);
    if(_data!=null){
      return CommentModel.fromMap(_data["commentData"]);
    }else{
      return null;
    }
  }

  Future<ReplyModel> addAdReply(String id,String reply)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "commentId":id,
      "text":reply
    };
    var _data = await DioHelper().post("/api/v1/AddReplyForCommentAsync", body);
    return (_data!=null)?ReplyModel.fromMap(_data["replyData"]):null;
  }

  Future<bool> removeComment(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "commentId":id,
    };
    var _data = await DioHelper().post("/api/v1/RemoveCommentToAdsByIdAsync", body);
    return (_data!=null);
  }

  Future<bool> removeReply(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "commentReplyId":id,
    };
    var _data = await DioHelper().post("/api/v1/RemoveCommentReplyByIdAsync", body);
    return (_data!=null);
  }

  Future<bool> addToFavourite(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":id,
    };
    var _data = await DioHelper().post("/api/v1/AddItemToWishlist", body);
    return (_data!=null);
  }

  Future<bool> removeFromFavourite(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":id,
    };
    var _data = await DioHelper().post("/api/v1/RemoveAdsToWishListForSiteAsync", body);
    return (_data!=null);
  }

  Future<List<AdsModel>> getFavouriteList(String lang)async{
    Map<String,dynamic> body={
      "lang":lang
    };
    var _data = await DioHelper().get("/api/v1/ListWishlist", body);
    if(_data!=null){
      return List<AdsModel>.from(_data["data"].map((e) => AdsModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<bool> addToFollower(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":id,
    };
    var _data = await DioHelper().post("/api/v1/AddItemToFollow", body);
    return (_data!=null);
  }

  Future<bool> removeFromFollower(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "AdsId":id,
    };
    var _data = await DioHelper().post("/api/v1/RemoveItemFromFollow", body);
    return _data!=null;
  }

  Future<bool> addUserToFollower(String userId)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "fkUserFollow":userId,
    };
    var _data = await DioHelper().post("/api/v1/AddUserToFollow", body);
    return (_data!=null);
  }

  Future<bool> addAdsReport(String id,String reason)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":id,
      "reason":reason
    };
    var _data = await DioHelper().post("/api/v1/AddReporToAds", body);
    return (_data!=null);
  }

  Future<UserDetailsModel> getUserAds(String userId,String lang,bool refresh)async{
    Map<String,dynamic> body={
      "lang":lang,
      "userId":userId,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListAdsByUserId", body);
    if(_data!=null){
      UserDetailsModel model = UserDetailsModel(
        ads: List<AdsModel>.from(_data["data"].map((e) => AdsModel.fromMap(e))),
        userData: AdOwnerModel.fromMap(_data["dataUser"])
      );
      model.userData.showFollow=_data["checkFollowOrNo"];
      model.userData.showRate=_data["checkrateOrNo"];
      return model;
    }else{
      return null;
    }
  }

  Future<List<CommentModel>> getUserComments(String id,bool refresh)async{
    var lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "userId":id,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListCommentsLikesByUserId", body);
    if(_data!=null){
      return List<CommentModel>.from(_data["data"].map((e) => CommentModel.fromMap(e)));
    }else{
      return [];
    }
  }

  Future<CommentModel> addUserComments(String adsId,String comment)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "userId":adsId,
      "comment":comment
    };
    var _data = await DioHelper().post("/api/v1/AddCommentToUserAsync", body);
    if(_data!=null){
      return CommentModel.fromMap(_data["comment"]);
    }else{
      return null;
    }
  }

  Future<bool> removeUserComment(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "commentId":id,
    };
    var _data = await DioHelper().post("/api/v1/RemoveCommentByIdAsync", body);
    return (_data!=null);
  }

  Future<List<EditAdModel>> getMyAds(String lang,bool refresh)async{
    Map<String,dynamic> body={
      "lang":lang,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListMyAds", body);
    if(_data!=null){
      return List<EditAdModel>.from(_data["data"].map((e) => EditAdModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<List<CommentModel>> getMyComments(String lang)async{
    Map<String,dynamic> body={
      "lang":lang,
    };
    var _data = await DioHelper().get("/api/v1/ListCommentsLikesByForMy", body);
    if(_data!=null){
      UserModel user=UserModel.fromJson(_data["userData"]);
      user.token=GlobalState.instance.get("token");
      await Utils.saveUserData(user);
      context.read<UserCubit>().onUpdateUserData(user);
      return List<CommentModel>.from(_data["data"].map((e) => CommentModel.fromMap(e)));
    }else{
      return [];
    }
  }

  Future<int> addUserRate(String userId,int rate)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "userId":userId,
      "rate":rate
    };
    var _data = await DioHelper().post("/api/v1/AddRateToUserAsync", body);
    return(_data!=null)?_data["rate"]:0;
  }

  Future<List<AdsModel>> getFollowedAds(bool refresh)async{
    var lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListFollowAdsForAppAsync", body);
    if(_data!=null){
      return List<AdsModel>.from(_data["data"].map((e) => AdsModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<bool> removeFollowAd(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "AdsId":id,
    };
    var _data = await DioHelper().post("/api/v1/RemoveFollowByIdForWebsiteAsync", body);
    return (_data!=null);
  }

  Future<List<UserFollowerModel>> getFollowedUsers(bool refresh)async{
    var lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListFollowUserForAppAsync", body);
    if(_data!=null){
      return List<UserFollowerModel>.from(_data["data"].map((e) => UserFollowerModel.fromMap(e)));
    }else{
      return null;
    }
  }

  Future<bool> removeFollowUser(String id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "followID":id,
    };
    var _data = await DioHelper().post("/api/v1/RemoveItemFromFollow", body);
    return (_data!=null);
  }

  Future<List<SearchModel>> getSearchAds(String text)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "text":text,
    };
    var _data = await DioHelper(forceRefresh: false).get("/api/v1/SearchInBranch", body);
    if(_data!=null){
      return List<SearchModel>.from(_data["data"].map((e) => SearchModel.fromMap(e)));
    }else{
      return [];
    }
  }

  Future<List<NotifyModel>> getNotifications(String lang,bool refresh)async{
    Map<String,dynamic> body={
      "lang":lang,
    };
    var _data = await DioHelper(forceRefresh: refresh).get("/api/v1/ListOfNotify", body);
    if(_data!=null){
      return List<NotifyModel>.from(_data["notify"].map((e) => NotifyModel.fromMap(e)));
    }else{
      return [];
    }
  }

  Future<bool> removeNotification(int id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "notifyId":"$id"
    };
    var _data = await DioHelper().post("/api/v1/RemoveNotiyByIdAsync", body);
    return (_data!=null);
  }

  Future<bool> removeNotifications()async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
    };
    var _data = await DioHelper().post("/api/v1/RemoveAllNotiy", body);
    return (_data!=null);
  }

  Future<bool> removeMyAd(int id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":"$id"
    };
    var _data = await DioHelper().post("/api/v1/ReomveAdsById", body);
    return (_data!=null);
  }

  Future<bool> removeAdImage(int id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "ImgId":"$id"
    };
    var _data = await DioHelper().post("/api/v1/ReomveImgId", body);
    return (_data!=null);
  }

  Future<bool> addPayment(AddPayModel model)async{
    var _data = await DioHelper().uploadFile("/api/v1/AddBankTransferAsync", model.toJson());
    return (_data!=null);
  }

  Future<List<BankModel>> getBanks()async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
    };
    var _data = await DioHelper().get("/api/v1/ListBanks", body);
    if(_data!=null){
      return List<BankModel>.from(_data["data"].map((e) => BankModel.fromMap(e)));
    }else{
      return [];
    }
  }

  Future<bool> refreshMyAd(int id)async{
    String lang = context.read<LangCubit>().state.locale.languageCode;
    Map<String,dynamic> body={
      "lang":lang,
      "adsId":"$id",
    };
    var _data = await DioHelper().post("/api/v1/RefreshAdsAsync", body);
    return (_data!=null);
  }


}