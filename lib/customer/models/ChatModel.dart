import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class ChatModel{

  ChatModel({
    this.id,
    this.userId,
    this.userName,
    this.lastMessage,
    this.date,
  });

  int id;
  String userId;
  String userName;
  String lastMessage;
  String image;
  String date;


  factory ChatModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<ChatModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}