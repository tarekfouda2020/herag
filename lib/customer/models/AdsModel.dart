import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;

import 'AdsDataModel.dart';


@jsonSerializable
class AdsModel  {

  AdsModel({
    this.id,
    this.title,
    this.img,
    this.date,
    this.userName,
    this.location,
    this.lat,
    this.lng,
    this.countComment,
    this.checkRate,
    this.allImg,
    this.checkWishList,
    this.fromAppOrNo,
    this.info
  });

  int id;
  String title;
  String img;
  String date;
  String userName;
  String location;
  String lat;
  String lng;
  int countComment;
  bool checkRate;
  bool checkWishList;
  List<String> allImg;
  @JsonProperty(name: "adsInfo")
  AdsDataModel info;
  bool fromAppOrNo;


  factory AdsModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<AdsModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}