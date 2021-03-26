import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/Dtos/RegisterModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';


class RegisterCompleteData{
  static final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final TextEditingController name = new TextEditingController();
  static final TextEditingController password = new TextEditingController();



  static void setUserRegister(BuildContext context,RegisterModel model) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if(formKey.currentState.validate()){
      model.userName=name.text;
      model.password=password.text;
      bool result= await CustomerRepository(context).userRegister(model);
      if(result!=null){
        AutoRouter.of(context).popUntilRouteWithName(LoginRoute.name);
      }

    }

  }
}