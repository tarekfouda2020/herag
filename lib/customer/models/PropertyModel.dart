import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class PropertyModel  {

  PropertyModel({
    this.id,
    this.name,
  });

  int id;
  @JsonProperty(name: "valueSpecifications")
  String name;

  factory PropertyModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<PropertyModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}