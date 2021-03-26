import 'dart:io';

import 'package:base_flutter/general/utilities/moor_db/db.dart';

class AddAdsModel {

  AddAdsModel ({
    this.images,
    this.lang,
    this.title,
    this.location,
    this.phone,
    this.description,
    this.price,
    this.lng,
    this.lat,
    this.determinePrice,
    this.fkCat,
    this.fkCity,
    this.fkDistrict,
    this.fkHeaderAds,
    this.fkRegion,
    this.fromAppOrNo,
    this.showPhone,
    this.category,
  });

  String fkHeaderAds;
  String fkRegion;
  String fkCity;
  String fkCat;
  String fkDistrict;
  String title;
  String lat;
  String lng;
  String location;
  String determinePrice;
  String showPhone;
  String phone;
  String price;
  String description;
  String notes;
  bool closeReply;
  String lang;
  Category category;
  String fromAppOrNo;
  List<File> images;


  Map<String, dynamic> toJson() => {
    "imgs":images,
    "fkRegoin":fkRegion,
    "fkHeaderAds":fkHeaderAds,
    "fkCity":fkCity,
    "fkCat":fkCat,
    "fkDistrict":fkDistrict,
    "title":title,
    "lat":lat,
    "lng":lng,
    "location":location,
    "determinePrice":determinePrice,
    "showPhone":showPhone,
    "phone":phone,
    "closeReply":closeReply,
    "price":price,
    "description":description,
    "FromAppOrNo":fromAppOrNo,
    "lang":lang,
    "notes":notes

  };

}