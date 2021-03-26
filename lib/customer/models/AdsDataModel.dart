import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;

import 'CommentModel.dart';
import 'ImageModel.dart';


@jsonSerializable
class AdsDataModel  {

  AdsDataModel({
    this.id,
    this.title,
    this.date,
    this.userName,
    this.catId,
    this.location,
    this.lat,
    this.lng,
    this.phone,
    this.description,
    this.countFavorite,
    this.countComment,
    this.showPhone,
    this.price,
    this.showPrice,
    this.checkFollows,
    this.countReport,
    this.checkRate,
    this.checkWishList,
    this.allImg,
    this.fkUser,
    this.checkReport,
    this.fromAppOrNo,
    this.whatsapp,
    this.closeReply,
    this.showMap,
    this.userPhone,
    this.userRate,
    this.locationInfo,
    this.comments,
    this.km,
    this.notes,
  });

  int id;
  String title;
  String fkUser;
  String date;
  String userName;
  int catId;
  String location;
  String lat;
  String lng;
  String phone;
  String whatsapp;
  String userPhone;
  String description;
  String notes;
  String locationInfo;
  int countFavorite;
  int countComment;
  @JsonProperty(name: "elMamsha")
  int km;
  bool showPhone;
  int price;
  int userRate;
  bool fromAppOrNo;
  bool showPrice;
  bool checkFollows;
  int countReport;
  bool checkRate;
  bool checkReport;
  bool checkWishList;
  bool closeReply;
  bool showMap;
  List<ImageModel> allImg;
  List<CommentModel> comments;




  factory AdsDataModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<AdsDataModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}