import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;
import 'package:base_flutter/customer/models/SpecificationGroupModel.dart';


@jsonSerializable
class SpecificationHeaderModel  {

  SpecificationHeaderModel({
    this.title,
    this.id,
    this.groupList,
    this.selectedId,
  });

  String title;
  int id;
  @JsonProperty(defaultValue: 0)
  int selectedId;
  @JsonProperty(name: "valueHeaderSpecifications")
  List<SpecificationGroupModel> groupList;


  factory SpecificationHeaderModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<SpecificationHeaderModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}