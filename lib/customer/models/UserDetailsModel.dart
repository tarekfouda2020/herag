import 'package:base_flutter/customer/models/AdsModel.dart';

import 'AdOwnerModel.dart';

class UserDetailsModel {
  UserDetailsModel({this.ads, this.userData});

  List<AdsModel> ads;
  AdOwnerModel userData;

}
