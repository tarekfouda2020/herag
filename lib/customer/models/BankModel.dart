import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;

@jsonSerializable
class BankModel {

  BankModel({
    this.id,
    this.img,
    this.accountNumber,
    this.ibandNumber,
    this.bannkName,
    this.beneficiaryName,
  });

  int id;
  String img;
  String accountNumber;
  String ibandNumber;
  String bannkName;
  String beneficiaryName;

  factory BankModel.fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<BankModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);
}