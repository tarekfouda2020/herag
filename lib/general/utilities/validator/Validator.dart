import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';


class Validator{

  final BuildContext context;

  Validator(this.context);

  String noValidate({@required String value}){
    return null;
  }

  String validateEmpty({@required String value,String message}){
    if(value.trim().isEmpty){
      return message??tr(context,"fillField");
    }
    return null;
  }

  String validateDropDown<DataType>({@required DataType model,String message}){
    if(model==null){
      return message??tr(context,"fillField");
    }
    return null;
  }

  String validatePassword({@required String value,String message}){
    if(value.trim().isEmpty){
      return message??tr(context,"fillField");
    }else if(value.length<6){
      return message??tr(context,"passValidation");
    }
    return null;
  }

  String validateEmail({@required String value,String message}){
    if(value.trim().isEmpty){
      return message??tr(context,"fillField");
    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
      return message??tr(context,"mailValidation");
    }
    return null;
  }
  String validateEmailORNull({@required String value,String message}){
    if(value.trim().isNotEmpty){
      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
        return message??tr(context,"mailValidation");
      }
    }
    return null;
  }

  String validatePhone({@required String value,String message}){
    if(value.trim().isEmpty){
      return message??tr(context,"fillField");
    }else if(!RegExp(r'(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)').hasMatch(value)||value.length<10){
      return message??tr(context,"phoneValidation");
    }
    return null;
  }

  String validatePasswordConfirm({@required String confirm,@required String pass,String message}){
    if(confirm.trim().isEmpty){
      return message??tr(context,"fillField");
    }else if(confirm!=pass){
      return message??tr(context,"confirmValidation");
    }
    return null;
  }

}