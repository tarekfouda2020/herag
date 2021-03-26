import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class OffersHeaderModel  {

  OffersHeaderModel({
    this.id,
    this.title,
    this.icon,
  });

  int id;
  String title;
  String icon;

  factory OffersHeaderModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<OffersHeaderModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}