import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;
import 'package:base_flutter/customer/models/AdsDataModel.dart';



@jsonSerializable
class EditAdModel {

  EditAdModel({
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
    this.checkWishList
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
  bool fromAppOrNo;
  bool checkRate;
  bool checkWishList;
  List<String> allImg;
  @JsonProperty(name: "adsInfo")
  AdsDataModel info;

  factory EditAdModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<EditAdModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}