import 'dart:io';

class UpdateProfileModel {
  final String userName;
  final String email;
  final String phone;
  final String lat;
  final String lng;
  final String address;
  final String phone1;
  final String phone2;
  final String phone3;
  final String description;
  final File imgCover;
  final File imgProfile;

  UpdateProfileModel(
      {this.userName,
      this.email,
      this.phone,
      this.lat,
      this.lng,
      this.imgProfile,
      this.address,
      this.phone1,
      this.phone2,
      this.phone3,
      this.description,
      this.imgCover});
  Map<String , dynamic> toJson()=>{
    "userName":userName,
    "email":email,
    "phone1":phone1,
    "phone2":phone2,
    "phone3":phone3,
    "phone":phone,
    "lat":lat,
    "lng":lng,
    "address":address,
    "description":description,
    "imgProfile":imgProfile,
    "imgCover":imgCover,

  };
}
