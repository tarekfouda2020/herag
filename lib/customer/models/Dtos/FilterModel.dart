import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class FilterModel {

  FilterModel ({
    this.cityId,
    this.catId,
    this.regionId,
    this.pageNumber,
    this.pageSize,
    this.typeFilter,
    this.lang,
    this.lng,
    this.lat,
    this.title,
});

  @JsonProperty(name: "typeFiltter")
  String typeFilter;
  String catId;
  @JsonProperty(name: "regoinId")
  String regionId;
  String cityId;
  String pageNumber;
  String pageSize;
  String lang;
  String lat;
  String lng;
  String title;


  factory FilterModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<FilterModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}