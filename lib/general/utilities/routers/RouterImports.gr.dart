// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:base_flutter/customer/models/AdsDataModel.dart' as _i46;
import 'package:base_flutter/customer/models/AdsModel.dart' as _i45;
import 'package:base_flutter/customer/models/Dtos/AddAdsModel.dart' as _i44;
import 'package:base_flutter/customer/models/Dtos/RegisterModel.dart' as _i41;
import 'package:base_flutter/customer/models/Dtos/UpdateAdModel.dart' as _i47;
import 'package:base_flutter/customer/models/ImageModel.dart' as _i49;
import 'package:base_flutter/customer/models/OffersHeaderModel.dart' as _i43;
import 'package:base_flutter/customer/screens/add_car_followers/AddCarFollower.dart'
    as _i31;
import 'package:base_flutter/customer/screens/add_offer_details/OfferDetailsImports.dart'
    as _i17;
import 'package:base_flutter/customer/screens/add_offer_images/AddOfferImagesImports.dart'
    as _i18;
import 'package:base_flutter/customer/screens/add_offer_location/AddOfferLocImports.dart'
    as _i15;
import 'package:base_flutter/customer/screens/add_offer_success/OfferSuccessImports.dart'
    as _i19;
import 'package:base_flutter/customer/screens/add_offers/AddOfferImports.dart'
    as _i13;
import 'package:base_flutter/customer/screens/admin_banks/AdminBanksImports.dart'
    as _i36;
import 'package:base_flutter/customer/screens/bank_payment/BankPaymentImports.dart'
    as _i37;
import 'package:base_flutter/customer/screens/call_us/CallUsImports.dart'
    as _i38;
import 'package:base_flutter/customer/screens/change_password/ChangePasswordImports.dart'
    as _i34;
import 'package:base_flutter/customer/screens/chat/ChatImports.dart' as _i24;
import 'package:base_flutter/customer/screens/edit_offer_details/EditDetailsImports.dart'
    as _i28;
import 'package:base_flutter/customer/screens/edit_offer_images/EditOfferImagesImports.dart'
    as _i26;
import 'package:base_flutter/customer/screens/edit_offer_location/EditOfferLocImports.dart'
    as _i27;
import 'package:base_flutter/customer/screens/edit_offer_success/EditOfferSuccessImports.dart'
    as _i29;
import 'package:base_flutter/customer/screens/edit_profile/EditProfileImports.dart'
    as _i33;
import 'package:base_flutter/customer/screens/filter_location/FilterLocationImports.dart'
    as _i39;
import 'package:base_flutter/customer/screens/followers/FollowerImports.dart'
    as _i30;
import 'package:base_flutter/customer/screens/home/HomeImports.dart' as _i12;
import 'package:base_flutter/customer/screens/location_address/LocationAddressImports.dart'
    as _i16;
import 'package:base_flutter/customer/screens/my_products/MyProductsImports.dart'
    as _i25;
import 'package:base_flutter/customer/screens/offer_swearing/OfferSwearingImports.dart'
    as _i14;
import 'package:base_flutter/customer/screens/product_comments/ProCommentsImports.dart'
    as _i21;
import 'package:base_flutter/customer/screens/product_details/ProDetailsImports.dart'
    as _i20;
import 'package:base_flutter/customer/screens/profile/ProfileImports.dart'
    as _i32;
import 'package:base_flutter/customer/screens/register/Register.dart' as _i4;
import 'package:base_flutter/customer/screens/register/register_complete/RegisterComplete.dart'
    as _i5;
import 'package:base_flutter/customer/screens/user_comments/UserCommentsImports.dart'
    as _i23;
import 'package:base_flutter/customer/screens/user_products/UserProductsImports.dart'
    as _i22;
import 'package:base_flutter/general/models/PageModel.dart' as _i42;
import 'package:base_flutter/general/models/UserModel.dart' as _i48;
import 'package:base_flutter/general/screens/active_account/ActiveAccount.dart'
    as _i7;
import 'package:base_flutter/general/screens/ContactUs.dart' as _i11;
import 'package:base_flutter/general/screens/forget_password/ForgetPasswordImports.dart'
    as _i6;
import 'package:base_flutter/general/screens/ImageZoom.dart' as _i35;
import 'package:base_flutter/general/screens/login/LoginImports.dart' as _i3;
import 'package:base_flutter/general/screens/remote_page/RemotePage.dart'
    as _i9;
import 'package:base_flutter/general/screens/reset_password/ResetPasswordImports.dart'
    as _i8;
import 'package:base_flutter/general/screens/splash/AnimatedSplash.dart' as _i2;
import 'package:base_flutter/general/screens/Terms.dart' as _i10;
import 'package:flutter/material.dart' as _i40;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    AnimatedSplashRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i2.AnimatedSplash());
    },
    LoginRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i3.Login());
    },
    RegisterRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i4.Register());
    },
    RegisterCompleteRoute.name: (entry) {
      var args = entry.routeData.argsAs<RegisterCompleteRouteArgs>(
          orElse: () => RegisterCompleteRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i5.RegisterComplete(key: args.key, model: args.model));
    },
    ForgetPasswordRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i6.ForgetPassword());
    },
    ActiveAccountRoute.name: (entry) {
      var args = entry.routeData.argsAs<ActiveAccountRouteArgs>(
          orElse: () => ActiveAccountRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i7.ActiveAccount(key: args.key, model: args.model));
    },
    ResetPasswordRoute.name: (entry) {
      var args = entry.routeData.argsAs<ResetPasswordRouteArgs>(
          orElse: () => ResetPasswordRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i8.ResetPassword(userId: args.userId));
    },
    RemotePageRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<RemotePageRouteArgs>(orElse: () => RemotePageRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i9.RemotePage(page: args.page));
    },
    TermsRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i10.Terms());
    },
    ContactUsRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i11.ContactUs());
    },
    HomeRoute.name: (entry) {
      var args =
          entry.routeData.argsAs<HomeRouteArgs>(orElse: () => HomeRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i12.Home(parentCount: args.parentCount, tab: args.tab));
    },
    AddOffersRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i13.AddOffers());
    },
    OfferSwearingRoute.name: (entry) {
      var args = entry.routeData.argsAs<OfferSwearingRouteArgs>(
          orElse: () => OfferSwearingRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i14.OfferSwearing(model: args.model));
    },
    AddOfferLocationRoute.name: (entry) {
      var args = entry.routeData.argsAs<AddOfferLocationRouteArgs>(
          orElse: () => AddOfferLocationRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i15.AddOfferLocation(model: args.model));
    },
    LocationAddressRoute.name: (entry) {
      var args = entry.routeData.argsAs<LocationAddressRouteArgs>(
          orElse: () => LocationAddressRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i16.LocationAddress(lat: args.lat, lng: args.lng));
    },
    AddOfferDetailsRoute.name: (entry) {
      var args = entry.routeData.argsAs<AddOfferDetailsRouteArgs>(
          orElse: () => AddOfferDetailsRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i17.AddOfferDetails(model: args.model));
    },
    AddOfferImagesRoute.name: (entry) {
      var args = entry.routeData.argsAs<AddOfferImagesRouteArgs>(
          orElse: () => AddOfferImagesRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i18.AddOfferImages(model: args.model));
    },
    AddOfferSuccessRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i19.AddOfferSuccess());
    },
    ProductDetailsRoute.name: (entry) {
      var args = entry.routeData.argsAs<ProductDetailsRouteArgs>(
          orElse: () => ProductDetailsRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i20.ProductDetails(model: args.model, info: args.info));
    },
    ProductCommentsRoute.name: (entry) {
      var args = entry.routeData.argsAs<ProductCommentsRouteArgs>(
          orElse: () => ProductCommentsRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i21.ProductComments(
              adsId: args.adsId, hideReply: args.hideReply));
    },
    UserProductsRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<UserProductsRouteArgs>(orElse: () => UserProductsRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child:
              _i22.UserProducts(userId: args.userId, userName: args.userName));
    },
    UserCommentsRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<UserCommentsRouteArgs>(orElse: () => UserCommentsRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i23.UserComments(userId: args.userId));
    },
    ChatRoute.name: (entry) {
      var args =
          entry.routeData.argsAs<ChatRouteArgs>(orElse: () => ChatRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i24.Chat(
              senderId: args.senderId,
              receiverId: args.receiverId,
              userName: args.userName));
    },
    MyProductsRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i25.MyProducts());
    },
    EditOfferImagesRoute.name: (entry) {
      var args = entry.routeData.argsAs<EditOfferImagesRouteArgs>(
          orElse: () => EditOfferImagesRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i26.EditOfferImages(model: args.model));
    },
    EditOfferLocationRoute.name: (entry) {
      var args = entry.routeData.argsAs<EditOfferLocationRouteArgs>(
          orElse: () => EditOfferLocationRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child:
              _i27.EditOfferLocation(model: args.model, adModel: args.adModel));
    },
    EditOfferDetailsRoute.name: (entry) {
      var args = entry.routeData.argsAs<EditOfferDetailsRouteArgs>(
          orElse: () => EditOfferDetailsRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child:
              _i28.EditOfferDetails(model: args.model, adModel: args.adModel));
    },
    EditOfferSuccessRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i29.EditOfferSuccess());
    },
    FollowersRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i30.Followers());
    },
    AddCarFollowerRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i31.AddCarFollower());
    },
    ProfileRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i32.Profile());
    },
    EditProfileRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<EditProfileRouteArgs>(orElse: () => EditProfileRouteArgs());
      return _i1.AdaptivePage(
          entry: entry, child: _i33.EditProfile(user: args.user));
    },
    ChangePasswordRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i34.ChangePassword());
    },
    ImageZoomRoute.name: (entry) {
      var args = entry.routeData
          .argsAs<ImageZoomRouteArgs>(orElse: () => ImageZoomRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i35.ImageZoom(images: args.images, index: args.index));
    },
    AdminBanksRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i36.AdminBanks());
    },
    BankPaymentRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i37.BankPayment());
    },
    CallUsRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i38.CallUs());
    },
    FilterLocationRoute.name: (entry) {
      var args = entry.routeData.argsAs<FilterLocationRouteArgs>(
          orElse: () => FilterLocationRouteArgs());
      return _i1.AdaptivePage(
          entry: entry,
          child: _i39.FilterLocation(lat: args.lat, lng: args.lng));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(AnimatedSplashRoute.name, path: '/'),
        _i1.RouteConfig(LoginRoute.name, path: '/Login'),
        _i1.RouteConfig(RegisterRoute.name, path: '/Register'),
        _i1.RouteConfig(RegisterCompleteRoute.name, path: '/register-complete'),
        _i1.RouteConfig(ForgetPasswordRoute.name, path: '/forget-password'),
        _i1.RouteConfig(ActiveAccountRoute.name, path: '/active-account'),
        _i1.RouteConfig(ResetPasswordRoute.name, path: '/reset-password'),
        _i1.RouteConfig(RemotePageRoute.name, path: '/remote-page'),
        _i1.RouteConfig(TermsRoute.name, path: '/Terms'),
        _i1.RouteConfig(ContactUsRoute.name, path: '/contact-us'),
        _i1.RouteConfig(HomeRoute.name, path: '/Home'),
        _i1.RouteConfig(AddOffersRoute.name, path: '/add-offers'),
        _i1.RouteConfig(OfferSwearingRoute.name, path: '/offer-swearing'),
        _i1.RouteConfig(AddOfferLocationRoute.name,
            path: '/add-offer-location'),
        _i1.RouteConfig(LocationAddressRoute.name, path: '/location-address'),
        _i1.RouteConfig(AddOfferDetailsRoute.name, path: '/add-offer-details'),
        _i1.RouteConfig(AddOfferImagesRoute.name, path: '/add-offer-images'),
        _i1.RouteConfig(AddOfferSuccessRoute.name, path: '/add-offer-success'),
        _i1.RouteConfig(ProductDetailsRoute.name, path: '/product-details'),
        _i1.RouteConfig(ProductCommentsRoute.name, path: '/product-comments'),
        _i1.RouteConfig(UserProductsRoute.name, path: '/user-products'),
        _i1.RouteConfig(UserCommentsRoute.name, path: '/user-comments'),
        _i1.RouteConfig(ChatRoute.name, path: '/Chat'),
        _i1.RouteConfig(MyProductsRoute.name, path: '/my-products'),
        _i1.RouteConfig(EditOfferImagesRoute.name, path: '/edit-offer-images'),
        _i1.RouteConfig(EditOfferLocationRoute.name,
            path: '/edit-offer-location'),
        _i1.RouteConfig(EditOfferDetailsRoute.name,
            path: '/edit-offer-details'),
        _i1.RouteConfig(EditOfferSuccessRoute.name,
            path: '/edit-offer-success'),
        _i1.RouteConfig(FollowersRoute.name, path: '/Followers'),
        _i1.RouteConfig(AddCarFollowerRoute.name, path: '/add-car-follower'),
        _i1.RouteConfig(ProfileRoute.name, path: '/Profile'),
        _i1.RouteConfig(EditProfileRoute.name, path: '/edit-profile'),
        _i1.RouteConfig(ChangePasswordRoute.name, path: '/change-password'),
        _i1.RouteConfig(ImageZoomRoute.name, path: '/image-zoom'),
        _i1.RouteConfig(AdminBanksRoute.name, path: '/admin-banks'),
        _i1.RouteConfig(BankPaymentRoute.name, path: '/bank-payment'),
        _i1.RouteConfig(CallUsRoute.name, path: '/call-us'),
        _i1.RouteConfig(FilterLocationRoute.name, path: '/filter-location')
      ];
}

class AnimatedSplashRoute extends _i1.PageRouteInfo {
  const AnimatedSplashRoute() : super(name, path: '/');

  static const String name = 'AnimatedSplashRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/Login');

  static const String name = 'LoginRoute';
}

class RegisterRoute extends _i1.PageRouteInfo {
  const RegisterRoute() : super(name, path: '/Register');

  static const String name = 'RegisterRoute';
}

class RegisterCompleteRoute
    extends _i1.PageRouteInfo<RegisterCompleteRouteArgs> {
  RegisterCompleteRoute({_i40.Key key, _i41.RegisterModel model})
      : super(name,
            path: '/register-complete',
            args: RegisterCompleteRouteArgs(key: key, model: model));

  static const String name = 'RegisterCompleteRoute';
}

class RegisterCompleteRouteArgs {
  const RegisterCompleteRouteArgs({this.key, this.model});

  final _i40.Key key;

  final _i41.RegisterModel model;
}

class ForgetPasswordRoute extends _i1.PageRouteInfo {
  const ForgetPasswordRoute() : super(name, path: '/forget-password');

  static const String name = 'ForgetPasswordRoute';
}

class ActiveAccountRoute extends _i1.PageRouteInfo<ActiveAccountRouteArgs> {
  ActiveAccountRoute({_i40.Key key, _i41.RegisterModel model})
      : super(name,
            path: '/active-account',
            args: ActiveAccountRouteArgs(key: key, model: model));

  static const String name = 'ActiveAccountRoute';
}

class ActiveAccountRouteArgs {
  const ActiveAccountRouteArgs({this.key, this.model});

  final _i40.Key key;

  final _i41.RegisterModel model;
}

class ResetPasswordRoute extends _i1.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({String userId})
      : super(name,
            path: '/reset-password',
            args: ResetPasswordRouteArgs(userId: userId));

  static const String name = 'ResetPasswordRoute';
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.userId});

  final String userId;
}

class RemotePageRoute extends _i1.PageRouteInfo<RemotePageRouteArgs> {
  RemotePageRoute({_i42.PageModel page})
      : super(name,
            path: '/remote-page', args: RemotePageRouteArgs(page: page));

  static const String name = 'RemotePageRoute';
}

class RemotePageRouteArgs {
  const RemotePageRouteArgs({this.page});

  final _i42.PageModel page;
}

class TermsRoute extends _i1.PageRouteInfo {
  const TermsRoute() : super(name, path: '/Terms');

  static const String name = 'TermsRoute';
}

class ContactUsRoute extends _i1.PageRouteInfo {
  const ContactUsRoute() : super(name, path: '/contact-us');

  static const String name = 'ContactUsRoute';
}

class HomeRoute extends _i1.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({int parentCount, int tab = 0})
      : super(name,
            path: '/Home',
            args: HomeRouteArgs(parentCount: parentCount, tab: tab));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.parentCount, this.tab = 0});

  final int parentCount;

  final int tab;
}

class AddOffersRoute extends _i1.PageRouteInfo {
  const AddOffersRoute() : super(name, path: '/add-offers');

  static const String name = 'AddOffersRoute';
}

class OfferSwearingRoute extends _i1.PageRouteInfo<OfferSwearingRouteArgs> {
  OfferSwearingRoute({_i43.OffersHeaderModel model})
      : super(name,
            path: '/offer-swearing',
            args: OfferSwearingRouteArgs(model: model));

  static const String name = 'OfferSwearingRoute';
}

class OfferSwearingRouteArgs {
  const OfferSwearingRouteArgs({this.model});

  final _i43.OffersHeaderModel model;
}

class AddOfferLocationRoute
    extends _i1.PageRouteInfo<AddOfferLocationRouteArgs> {
  AddOfferLocationRoute({_i44.AddAdsModel model})
      : super(name,
            path: '/add-offer-location',
            args: AddOfferLocationRouteArgs(model: model));

  static const String name = 'AddOfferLocationRoute';
}

class AddOfferLocationRouteArgs {
  const AddOfferLocationRouteArgs({this.model});

  final _i44.AddAdsModel model;
}

class LocationAddressRoute extends _i1.PageRouteInfo<LocationAddressRouteArgs> {
  LocationAddressRoute({double lat, double lng})
      : super(name,
            path: '/location-address',
            args: LocationAddressRouteArgs(lat: lat, lng: lng));

  static const String name = 'LocationAddressRoute';
}

class LocationAddressRouteArgs {
  const LocationAddressRouteArgs({this.lat, this.lng});

  final double lat;

  final double lng;
}

class AddOfferDetailsRoute extends _i1.PageRouteInfo<AddOfferDetailsRouteArgs> {
  AddOfferDetailsRoute({_i44.AddAdsModel model})
      : super(name,
            path: '/add-offer-details',
            args: AddOfferDetailsRouteArgs(model: model));

  static const String name = 'AddOfferDetailsRoute';
}

class AddOfferDetailsRouteArgs {
  const AddOfferDetailsRouteArgs({this.model});

  final _i44.AddAdsModel model;
}

class AddOfferImagesRoute extends _i1.PageRouteInfo<AddOfferImagesRouteArgs> {
  AddOfferImagesRoute({_i43.OffersHeaderModel model})
      : super(name,
            path: '/add-offer-images',
            args: AddOfferImagesRouteArgs(model: model));

  static const String name = 'AddOfferImagesRoute';
}

class AddOfferImagesRouteArgs {
  const AddOfferImagesRouteArgs({this.model});

  final _i43.OffersHeaderModel model;
}

class AddOfferSuccessRoute extends _i1.PageRouteInfo {
  const AddOfferSuccessRoute() : super(name, path: '/add-offer-success');

  static const String name = 'AddOfferSuccessRoute';
}

class ProductDetailsRoute extends _i1.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({_i45.AdsModel model, _i46.AdsDataModel info})
      : super(name,
            path: '/product-details',
            args: ProductDetailsRouteArgs(model: model, info: info));

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.model, this.info});

  final _i45.AdsModel model;

  final _i46.AdsDataModel info;
}

class ProductCommentsRoute extends _i1.PageRouteInfo<ProductCommentsRouteArgs> {
  ProductCommentsRoute({int adsId, bool hideReply})
      : super(name,
            path: '/product-comments',
            args: ProductCommentsRouteArgs(adsId: adsId, hideReply: hideReply));

  static const String name = 'ProductCommentsRoute';
}

class ProductCommentsRouteArgs {
  const ProductCommentsRouteArgs({this.adsId, this.hideReply});

  final int adsId;

  final bool hideReply;
}

class UserProductsRoute extends _i1.PageRouteInfo<UserProductsRouteArgs> {
  UserProductsRoute({String userId, String userName})
      : super(name,
            path: '/user-products',
            args: UserProductsRouteArgs(userId: userId, userName: userName));

  static const String name = 'UserProductsRoute';
}

class UserProductsRouteArgs {
  const UserProductsRouteArgs({this.userId, this.userName});

  final String userId;

  final String userName;
}

class UserCommentsRoute extends _i1.PageRouteInfo<UserCommentsRouteArgs> {
  UserCommentsRoute({String userId})
      : super(name,
            path: '/user-comments',
            args: UserCommentsRouteArgs(userId: userId));

  static const String name = 'UserCommentsRoute';
}

class UserCommentsRouteArgs {
  const UserCommentsRouteArgs({this.userId});

  final String userId;
}

class ChatRoute extends _i1.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({String senderId, String receiverId, String userName})
      : super(name,
            path: '/Chat',
            args: ChatRouteArgs(
                senderId: senderId,
                receiverId: receiverId,
                userName: userName));

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({this.senderId, this.receiverId, this.userName});

  final String senderId;

  final String receiverId;

  final String userName;
}

class MyProductsRoute extends _i1.PageRouteInfo {
  const MyProductsRoute() : super(name, path: '/my-products');

  static const String name = 'MyProductsRoute';
}

class EditOfferImagesRoute extends _i1.PageRouteInfo<EditOfferImagesRouteArgs> {
  EditOfferImagesRoute({_i46.AdsDataModel model})
      : super(name,
            path: '/edit-offer-images',
            args: EditOfferImagesRouteArgs(model: model));

  static const String name = 'EditOfferImagesRoute';
}

class EditOfferImagesRouteArgs {
  const EditOfferImagesRouteArgs({this.model});

  final _i46.AdsDataModel model;
}

class EditOfferLocationRoute
    extends _i1.PageRouteInfo<EditOfferLocationRouteArgs> {
  EditOfferLocationRoute({_i47.UpdateAdModel model, _i46.AdsDataModel adModel})
      : super(name,
            path: '/edit-offer-location',
            args: EditOfferLocationRouteArgs(model: model, adModel: adModel));

  static const String name = 'EditOfferLocationRoute';
}

class EditOfferLocationRouteArgs {
  const EditOfferLocationRouteArgs({this.model, this.adModel});

  final _i47.UpdateAdModel model;

  final _i46.AdsDataModel adModel;
}

class EditOfferDetailsRoute
    extends _i1.PageRouteInfo<EditOfferDetailsRouteArgs> {
  EditOfferDetailsRoute({_i47.UpdateAdModel model, _i46.AdsDataModel adModel})
      : super(name,
            path: '/edit-offer-details',
            args: EditOfferDetailsRouteArgs(model: model, adModel: adModel));

  static const String name = 'EditOfferDetailsRoute';
}

class EditOfferDetailsRouteArgs {
  const EditOfferDetailsRouteArgs({this.model, this.adModel});

  final _i47.UpdateAdModel model;

  final _i46.AdsDataModel adModel;
}

class EditOfferSuccessRoute extends _i1.PageRouteInfo {
  const EditOfferSuccessRoute() : super(name, path: '/edit-offer-success');

  static const String name = 'EditOfferSuccessRoute';
}

class FollowersRoute extends _i1.PageRouteInfo {
  const FollowersRoute() : super(name, path: '/Followers');

  static const String name = 'FollowersRoute';
}

class AddCarFollowerRoute extends _i1.PageRouteInfo {
  const AddCarFollowerRoute() : super(name, path: '/add-car-follower');

  static const String name = 'AddCarFollowerRoute';
}

class ProfileRoute extends _i1.PageRouteInfo {
  const ProfileRoute() : super(name, path: '/Profile');

  static const String name = 'ProfileRoute';
}

class EditProfileRoute extends _i1.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({_i48.UserModel user})
      : super(name,
            path: '/edit-profile', args: EditProfileRouteArgs(user: user));

  static const String name = 'EditProfileRoute';
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({this.user});

  final _i48.UserModel user;
}

class ChangePasswordRoute extends _i1.PageRouteInfo {
  const ChangePasswordRoute() : super(name, path: '/change-password');

  static const String name = 'ChangePasswordRoute';
}

class ImageZoomRoute extends _i1.PageRouteInfo<ImageZoomRouteArgs> {
  ImageZoomRoute({List<_i49.ImageModel> images, int index})
      : super(name,
            path: '/image-zoom',
            args: ImageZoomRouteArgs(images: images, index: index));

  static const String name = 'ImageZoomRoute';
}

class ImageZoomRouteArgs {
  const ImageZoomRouteArgs({this.images, this.index});

  final List<_i49.ImageModel> images;

  final int index;
}

class AdminBanksRoute extends _i1.PageRouteInfo {
  const AdminBanksRoute() : super(name, path: '/admin-banks');

  static const String name = 'AdminBanksRoute';
}

class BankPaymentRoute extends _i1.PageRouteInfo {
  const BankPaymentRoute() : super(name, path: '/bank-payment');

  static const String name = 'BankPaymentRoute';
}

class CallUsRoute extends _i1.PageRouteInfo {
  const CallUsRoute() : super(name, path: '/call-us');

  static const String name = 'CallUsRoute';
}

class FilterLocationRoute extends _i1.PageRouteInfo<FilterLocationRouteArgs> {
  FilterLocationRoute({double lat, double lng})
      : super(name,
            path: '/filter-location',
            args: FilterLocationRouteArgs(lat: lat, lng: lng));

  static const String name = 'FilterLocationRoute';
}

class FilterLocationRouteArgs {
  const FilterLocationRouteArgs({this.lat, this.lng});

  final double lat;

  final double lng;
}
