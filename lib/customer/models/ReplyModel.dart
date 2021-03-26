import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;


@jsonSerializable
class ReplyModel {

  ReplyModel({
    this.id,
    this.fkComment,
    this.text,
    this.creationDate,
    this.userName,
    this.fKUser,
  });

  int id;
  @JsonProperty(name: "fk_Comment")
  int fkComment;
  String text;
  String creationDate;
  String userName;
  @JsonProperty(name: "fK_User")
  String fKUser;

  factory ReplyModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<ReplyModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}