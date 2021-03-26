import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class RegisterModel {

  String phone;
  String lang;
  String userName;
  String password;
  String code;

  RegisterModel({
    this.phone,
    this.lang,
    this.password,
    this.userName,
    this.code
  });


  factory RegisterModel.fromMap(Map<String, dynamic> json) =>  JsonMapper.fromMap<RegisterModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);
}
