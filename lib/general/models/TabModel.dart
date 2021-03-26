import 'package:base_flutter/general/models/PageModel.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class TabModel {

  TabModel({
    this.place,
    this.pages,
  });

  int place;
  List<PageModel> pages;

  factory TabModel.fromJson(Map<String, dynamic> json) => JsonMapper.fromMap<TabModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);
}