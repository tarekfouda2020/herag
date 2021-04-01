import 'dart:io';

import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/ContactModel.dart';
import 'package:base_flutter/customer/models/DropDownModel.dart';
import 'package:base_flutter/customer/models/Dtos/RegisterModel.dart';
import 'package:base_flutter/customer/models/Dtos/UpdateProfileModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/constants/GlobalState.dart';
import 'package:base_flutter/general/models/UserModel.dart';
import 'package:base_flutter/general/utilities/dio_helper/DioImports.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';


class CustomerAuthMethods{
  final BuildContext context;

  CustomerAuthMethods(this.context);


  Future<RegisterModel> sendCode(String phone)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String , dynamic> body={
      "lang":lang,
      "Phone":phone
    };
    var _data= await DioHelper(context: context).get("/api/v1/Send_code", body);
    if(_data!=null){
      return RegisterModel(phone: phone,lang: lang,code: "${_data["date"]["code"]}");
    }else{
      return null;
    }
  }

  Future<bool> changePassword(String oldPassword,String newPassword)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String , dynamic> body={
      "lang":lang,
      "newPassword":newPassword,
      "oldPassword":oldPassword
    };
    var _data= await DioHelper(context: context).post("/api/v1/ChangePassward", body);
    return _data!=null;
  }

  Future<RegisterModel> resendCode(RegisterModel model)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String , dynamic> body={
      "lang":lang,
      "Phone": model.phone
    };
    var _data= await DioHelper(context: context).post("/api/v1/Send_code", body);
    if(_data!=null){
      model.code=_data["date"]["code"].toString();
      return model;
    }else{
      return null;
    }
  }

  Future<bool> userRegister(RegisterModel model)async{
    var _data= await DioHelper(context: context).post("/api/v1/register", model.toJson());
    if(_data!=null){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> updateUserData(UpdateProfileModel model)async{
    var _data= await DioHelper(context: context).uploadFile("/api/v1/UpdateDataUser", model.toJson());
    if(_data!=null){
      UserModel user=UserModel.fromJson(_data["data"]);
      user.token=GlobalState.instance.get("token");
      await Utils.saveUserData(user);
      context.read<UserCubit>().onUpdateUserData(user);
      return true;
    }else{
      return false;
    }
  }

  Future<List<DropDownModel>> getContactReasons()async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String , dynamic> body={
      "lang":lang,
    };
    var _data= await DioHelper(context: context).get("/api/v1/ListReasonContactUs", body);
    if(_data!=null){
      return List<DropDownModel>.from(_data["data"].map((e) => DropDownModel.fromMap(e)));
    }else{
      return [];
    }
  }

  Future<ContactModel> getContactInfo()async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String , dynamic> body={
      "lang":lang,
    };
    var _data= await DioHelper(context: context).get("/api/v1/GetInfoContact", body);
    if(_data!=null){
      return ContactModel.fromMap(_data["data"]);
    }else{
      return ContactModel();
    }
  }


  Future<bool> contactUs(String msg,String reasonId,File file)async{
    String lang=context.read<LangCubit>().state.locale.languageCode;
    Map<String , dynamic> body={
      "lang":lang,
      "FK_ReasonContact":reasonId,
      "Message":msg,
      "FileName":file
    };
    var _data= await DioHelper(context: context).uploadFile("/api/v1/AddContactUsByReason", body);
    if(_data!=null){
      return true;
    }else{
      return false;
    }
  }

}