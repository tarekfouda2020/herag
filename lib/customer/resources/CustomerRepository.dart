import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:base_flutter/customer/models/AdsDetailsModel.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/customer/models/BankModel.dart';
import 'package:base_flutter/customer/models/ChatModel.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/customer/models/ContactModel.dart';
import 'package:base_flutter/customer/models/DropDownModel.dart';
import 'package:base_flutter/customer/models/Dtos/AddAdsModel.dart';
import 'package:base_flutter/customer/models/Dtos/AddPayModel.dart';
import 'package:base_flutter/customer/models/Dtos/FilterModel.dart';
import 'package:base_flutter/customer/models/Dtos/RegisterModel.dart';
import 'package:base_flutter/customer/models/Dtos/UpdateAdModel.dart';
import 'package:base_flutter/customer/models/Dtos/UpdateProfileModel.dart';
import 'package:base_flutter/customer/models/EditAdModel.dart';
import 'package:base_flutter/customer/models/MessageModel.dart';
import 'package:base_flutter/customer/models/NotifyModel.dart';
import 'package:base_flutter/customer/models/OffersHeaderModel.dart';
import 'package:base_flutter/customer/models/ReplyModel.dart';
import 'package:base_flutter/customer/models/SearchModel.dart';
import 'package:base_flutter/customer/models/SpecificationHeaderModel.dart';
import 'package:base_flutter/customer/models/UserDetailsModel.dart';
import 'package:base_flutter/customer/models/UserFollowerModel.dart';
import 'package:base_flutter/customer/resources/CustomerAdsMethods.dart';
import 'package:base_flutter/customer/resources/CustomerAuthMethods.dart';
import 'package:base_flutter/customer/resources/CustomerChatMethods.dart';

class CustomerRepository{

  CustomerAuthMethods _authMethods;
  CustomerAdsMethods _adsMethods;
  CustomerChatMethods _chatMethods;
  BuildContext _context;

  CustomerRepository(BuildContext buildContext){
    _context=buildContext;
    _authMethods=new CustomerAuthMethods(_context);
    _adsMethods=new CustomerAdsMethods(_context);
    _chatMethods=new CustomerChatMethods(_context);
  }

  Future<RegisterModel> sendCode(String phone) => _authMethods.sendCode(phone);

  Future<bool> changePassword(String oldPassword,String newPassword) => _authMethods.changePassword(oldPassword,newPassword);

  Future<RegisterModel> resendCode(RegisterModel model) => _authMethods.resendCode(model);

  Future<bool> userRegister(RegisterModel model) => _authMethods.userRegister(model);

  Future<bool> updateUserData(UpdateProfileModel model) => _authMethods.updateUserData(model);

  Future<List<AdsModel>> getAdsData(FilterModel model,bool refresh) => _adsMethods.getAdsData(model,refresh);

  Future<List<DropDownModel>> getRegionData() => _adsMethods.getRegionData();

  Future<List<DropDownModel>> getCitiesData(String regionId) => _adsMethods.getCitiesData(regionId);

  Future<List<DropDownModel>> getNeighborsData(String cityId) => _adsMethods.getNeighborsData(cityId);

  Future<List<OffersHeaderModel>> getOffersHeaderData(bool refresh) => _adsMethods.getOffersHeaderData(refresh);

  Future<List<SpecificationHeaderModel>> getOffersPropertyData(String catId) => _adsMethods.getOffersPropertyData(catId);

  Future<bool> setAddOffer(AddAdsModel model) => _adsMethods.setAddOffer(model);

  Future<bool> setEditOffer(UpdateAdModel model) => _adsMethods.setEditOffer(model);

  Future<AdsDetailsModel> getAdDetails(String adsId,String lang,bool refresh) => _adsMethods.getAdDetails(adsId,lang,refresh);

  Future<List<CommentModel>> getAdComments(String adsId,String lang,bool refresh) => _adsMethods.getAdComments(adsId,lang,refresh);

  Future<CommentModel> addAdComments(String adsId,String comment) => _adsMethods.addAdComments(adsId,comment);

  Future<ReplyModel> addAdReply(String id,String reply) => _adsMethods.addAdReply(id,reply);

  Future<bool> removeReply(String id) => _adsMethods.removeReply(id);
  
  Future<bool> removeComment(String id) => _adsMethods.removeComment(id);

  Future<bool> addToFavourite(String id) => _adsMethods.addToFavourite(id);

  Future<bool> removeFromFavourite(String id) => _adsMethods.removeFromFavourite(id);

  Future<List<AdsModel>> getFavouriteList(String lang) => _adsMethods.getFavouriteList(lang);

  Future<List<CommentModel>> getUserComments(String id,bool refresh) => _adsMethods.getUserComments(id,refresh);

  Future<bool> addToFollower(String id) => _adsMethods.addToFollower(id);

  Future<bool> removeFromFollower(String id) => _adsMethods.removeFromFollower(id);

  Future<bool> addUserToFollower(String userId) => _adsMethods.addUserToFollower(userId);

  Future<bool> addAdsReport(String id,String reason) => _adsMethods.addAdsReport(id, reason);

  Future<UserDetailsModel> getUserAds(String userId,String lang,bool refresh) => _adsMethods.getUserAds(userId,lang,refresh);

  Future<CommentModel> addUserComments(String userId,String comment) => _adsMethods.addUserComments(userId,comment);

  Future<bool> removeUserComment(String id) => _adsMethods.removeUserComment(id);

  Future<List<EditAdModel>> getMyAds(String lang,bool refresh) => _adsMethods.getMyAds(lang,refresh);

  Future<List<CommentModel>> getMyComments(String lang) => _adsMethods.getMyComments(lang);

  Future<int> addUserRate(String userId,int rate)=> _adsMethods.addUserRate(userId, rate);

  Future<List<AdsModel>> getFollowedAds(bool refresh) => _adsMethods.getFollowedAds(refresh);

  Future<bool> removeFollowAd(String id) => _adsMethods.removeFollowAd(id);

  Future<List<UserFollowerModel>> getFollowedUsers(bool refresh) => _adsMethods.getFollowedUsers(refresh);

  Future<bool> removeFollowUser(String id) => _adsMethods.removeFollowUser(id);

  Future<List<SearchModel>> getSearchAds(String text) => _adsMethods.getSearchAds(text);

  Future<List<NotifyModel>> getNotifications(String lang,bool refresh) => _adsMethods.getNotifications(lang,refresh);

  Future<bool> removeNotification(int id) => _adsMethods.removeNotification(id);

  Future<bool> removeNotifications() => _adsMethods.removeNotifications();

  Future<bool> removeMyAd(int id) => _adsMethods.removeMyAd(id);

  Future<bool> refreshMyAd(int id)=> _adsMethods.refreshMyAd(id);

  Future<bool> removeAdImage(int id) => _adsMethods.removeAdImage(id);

  Future<List<ChatModel>> getListChatUsers(bool refresh) => _chatMethods.getListChatUsers(refresh);

  Future<List<MessageModel>> getListChatMessages(String ReceiverId,int page) =>
      _chatMethods.getListChatMessages(ReceiverId,page);

  Future<bool> addUserReport(String id,String reason) => _chatMethods.addUserReport(id, reason);

  Future<List<DropDownModel>> getContactReasons()=> _authMethods.getContactReasons();

  Future<ContactModel> getContactInfo()=> _authMethods.getContactInfo();

  Future<bool> contactUs(String msg,String reasonId,File file)=> _authMethods.contactUs(msg, reasonId, file);

  Future<bool> addPayment(AddPayModel model) => _adsMethods.addPayment(model);

  Future<List<BankModel>> getBanks() => _adsMethods.getBanks();

}