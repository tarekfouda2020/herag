import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class MessageModel{

  MessageModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.date,
  });

  int id;
  String senderId;
  String receiverId;
  String message;
  String date;


  factory MessageModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<MessageModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}