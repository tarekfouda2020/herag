import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;

@jsonSerializable
class UserModel {

  UserModel({
  this.id,
  this.userName,
  this.email,
  this.phone,
  this.lat,
  this.lng,
  this.address,
  this.lang,
  this.closeNotify,
  this.fkBranch,
  this.imgCover,
  this.imgProfile,
  this.uniqId,
  this.lastSeen,
  this.pocketMony,
  this.phone1,
  this.phone2,
  this.phone3,
  this.token,
  this.description,
  });

  String id;
  String userName;
  String email;
  String phone;
  String lat;
  String lng;
  String address;
  String lang;
  bool closeNotify;
  int fkBranch;
  String imgCover;
  String imgProfile;
  String uniqId;
  String lastSeen;
  int pocketMony;
  String phone1;
  String phone2;
  String phone3;
  String token;
  String description;
  int rate;
  String publishDate;


  factory UserModel.fromJson(Map<String, dynamic> json) => JsonMapper.fromMap<UserModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);
}