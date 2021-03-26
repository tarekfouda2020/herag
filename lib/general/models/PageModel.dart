import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class PageModel {

  PageModel({
    this.name,
    this.id,
    this.showInApp
  });

  String name;
  int id;
  bool showInApp;


  factory PageModel.fromJson(Map<String, dynamic> json) => JsonMapper.fromMap<PageModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);
}