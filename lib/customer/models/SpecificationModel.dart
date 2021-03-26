import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;
import 'package:base_flutter/customer/models/PropertyModel.dart';


@jsonSerializable
class SpecificationModel  {

  SpecificationModel({
    this.id,
    this.name,
    this.type,
    this.props,
    this.selectedId,
    this.value=0
  });

  int id;
  @JsonProperty(name: "titleSpecifications")
  String name;
  int type;
  int selectedId;
  @JsonProperty(defaultValue: 0,ignore: true)
  int value;
  @JsonProperty(name: "valueSpecificationsList",)
  List<PropertyModel> props;

  factory SpecificationModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<SpecificationModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}