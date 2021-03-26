import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class AdOwnerModel{


  AdOwnerModel({
    this.id,
    this.userName,
    this.email,
    this.phone,
    this.lat,
    this.lng,
    this.address,
    this.lang,
    this.fkBranch,
    this.imgCover,
    this.imgProfile,
    this.uniqId,
    this.lastSeen,
    this.publishDate,
    this.pocketMony,
    this.rate,
    this.showRate,
    this.showFollow
  });

  String id;
  String userName;
  String email;
  String phone;
  String lat;
  String lng;
  String address;
  String lang;
  int fkBranch;
  String imgCover;
  String imgProfile;
  String uniqId;
  DateTime lastSeen;
  String publishDate;
  int pocketMony;
  int rate;
  @JsonProperty(ignore: true,defaultValue: false)
  bool showRate;
  @JsonProperty(ignore: true,defaultValue: false)
  bool showFollow;

  factory AdOwnerModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<AdOwnerModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}