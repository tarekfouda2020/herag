import 'dart:io';

class UpdateAdModel {

  UpdateAdModel ({
    this.images,
    this.lang,
    this.title,
    this.location,
    this.description,
    this.lng,
    this.lat,
    this.fkCity,
    this.fkDistrict,
    this.fkRegion,
    this.adsId,
    this.closeReply,
    this.showMap
});

  String adsId;
  String fkRegion;
  String fkCity;
  String fkDistrict;
  String title;
  String lat;
  String lng;
  String location;
  String closeReply;
  String showMap;
  String description;
  String lang;
  List<File> images;


  Map<String, dynamic> toJson() => {
    "imgs":images,
    "FkRegoin":fkRegion,
    "AdsId":adsId,
    "FkCity":fkCity,
    "FkDistrict":fkDistrict,
    "CloseReply":closeReply,
    "lat":lat,
    "lng":lng,
    "Location":location,
    "ShowMap":showMap,
    "Description":description,
    "lang":lang,
    "Title":title

  };

}