import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class ImageModel {

  ImageModel ({
    this.url,
    this.id
});

  String url;
  int id;

  factory ImageModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<ImageModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}