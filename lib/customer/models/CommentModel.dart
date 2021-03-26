import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty, enumConverterNumeric;

import 'ReplyModel.dart';


@jsonSerializable
class CommentModel  {

  CommentModel({
    this.id,
    this.text,
    this.creationDate,
    this.userName,
    this.fKUser,
    this.fkAdsDetails,
  });

  int id;
  String text;
  String creationDate;
  String userName;
  @JsonProperty(name: "fK_User")
  String fKUser;
  @JsonProperty(name: "fk_AdsDetails")
  int fkAdsDetails;
  @JsonProperty(name: "commentReplys")
  List<ReplyModel> replyList;

  factory CommentModel .fromMap(Map<String, dynamic> json) => JsonMapper.fromMap<CommentModel>(json);
  Map<String, dynamic> toJson() => JsonMapper.toMap(this);

}