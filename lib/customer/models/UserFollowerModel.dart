import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class UserFollowerModel {

  UserFollowerModel({
    this.id,
    this.fKUserFollow,
    this.adsId,
    this.type,
    this.titleAds,
    this.date,
    this.userName,
    this.userId,
  });

  int id;
  @JsonProperty(name: "fK_UserFollow")
  String fKUserFollow;
  int adsId;
  int type;
  String titleAds;
  String date;
  String userName;
  @JsonProperty(name: "userID")
  String userId;

  factory UserFollowerModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<UserFollowerModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}