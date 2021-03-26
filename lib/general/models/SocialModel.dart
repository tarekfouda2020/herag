// To parse this JSON data, do
//
//     final socialModel = socialModelFromJson(jsonString);

import 'dart:convert';

SocialModel socialModelFromJson(String str) => SocialModel.fromJson(json.decode(str));

String socialModelToJson(SocialModel data) => json.encode(data.toJson());

class SocialModel {
  SocialModel({
    this.phone,
    this.email,
    this.whatsapp,
    this.emailChat,
    this.location,
    this.facebook,
    this.instgram,
    this.twitter,
    this.linkedin,
  });

  String phone;
  String email;
  String whatsapp;
  String emailChat;
  String location;
  String facebook;
  String instgram;
  String twitter;
  String linkedin;

  factory SocialModel.fromJson(Map<String, dynamic> json) => SocialModel(
    phone: json["phone"],
    email: json["email"],
    whatsapp: json["whatsapp"],
    emailChat: json["email_chat"],
    location: json["location"],
    facebook: json["facebook"],
    instgram: json["instgram"],
    twitter: json["twitter"],
    linkedin: json["linkedin"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
    "whatsapp": whatsapp,
    "email_chat": emailChat,
    "location": location,
    "facebook": facebook,
    "instgram": instgram,
    "twitter": twitter,
    "linkedin": linkedin,
  };
}
