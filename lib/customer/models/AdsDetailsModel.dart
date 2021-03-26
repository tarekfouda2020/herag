import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;
import 'package:base_flutter/customer/models/AdsModel.dart';

import 'AdsDataModel.dart';


@jsonSerializable
class AdsDetailsModel  {

  AdsDetailsModel({
    this.adsData,
    this.relatedAds,
  });

  @JsonProperty(name: "adsDtos")
  AdsDataModel adsData;
  List<AdsModel> relatedAds;

  factory AdsDetailsModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<AdsDetailsModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}