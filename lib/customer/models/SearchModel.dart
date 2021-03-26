import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;

import 'AdsModel.dart';


@jsonSerializable
class SearchModel {

  SearchModel({
    this.id,
    this.name,
    this.img,
    this.fKRegion,
    this.dateNumberDay,
    this.lat,
    this.lng,
  });

  int id;
  String name;
  String img;
  @JsonProperty(name: "fK_Region")
  int fKRegion;
  int dateNumberDay;
  String lat;
  String lng;
  AdsModel adsInfo;


  factory SearchModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<SearchModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

  @override
  String toString() {
    return name;
  }

}