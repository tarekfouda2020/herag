import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;
import 'package:equatable/equatable.dart';


@jsonSerializable
class DropDownModel {

  DropDownModel ({
    this.id,
    this.name,
    this.selected
});

  String name;
  int id;
  @JsonProperty(defaultValue: false,ignoreIfNull: true)
  bool selected;

  factory DropDownModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<DropDownModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

  @override
  String toString() {
    return name;
  }

}