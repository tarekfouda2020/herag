import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;
import 'package:base_flutter/customer/models/SpecificationModel.dart';


@jsonSerializable
class SpecificationGroupModel  {

  SpecificationGroupModel({
    this.name,
    this.id,
    this.specificationsList,
    this.selectedId
  });

  @JsonProperty(name: "value")
  String name;
  int id;
  int selectedId;
  @JsonProperty(name: "specificationsList")
  List<SpecificationModel> specificationsList;

  factory SpecificationGroupModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<SpecificationGroupModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}