import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;
import 'package:base_flutter/customer/models/AdsModel.dart';


@jsonSerializable
class NotifyModel {

  NotifyModel({
    this.id,
    this.text,
    this.date,
    this.adsId,
    this.fkUser,
    this.show,
  });

  int id;
  int type;
  String text;
  String date;
  @JsonProperty(name: "ads_id")
  int adsId;
  @JsonProperty(name: "fk_user")
  String fkUser;
  String userName;
  bool show;
  AdsModel adsInfo;

  factory NotifyModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<NotifyModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}