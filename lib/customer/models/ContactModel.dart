import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;

@jsonSerializable
class ContactModel {

  ContactModel({
    this.phone,
    this.address,
    this.lat,
    this.lng,
    this.email,
  });

  String phone;
  String address;
  String lat;
  String lng;
  String email;

  factory ContactModel.fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<ContactModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);
}