import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/Dtos/RegisterModel.dart';
import 'package:base_flutter/general/constants/Inputs/LabelTextField.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/validator/Validator.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/HeaderLogo.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

import 'RegisterCompleteData.dart';

class RegisterComplete extends StatefulWidget {
  final RegisterModel model;

  const RegisterComplete({Key key, @required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: RegisterCompleteData.scaffold,
      backgroundColor: MyColors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.only(bottom: 20),
        children: <Widget>[
          HeaderLogo(),

          //form inputs
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyText(
                        title: tr(context, "register"),
                        size: 16,
                        color: MyColors.primary,
                        alien: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Form(
                  key: RegisterCompleteData.formKey,
                  child: Column(
                    children: [
                      LabelTextField(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        type: TextInputType.text,
                        label: tr(context,"userName"),
                        isPassword: false,
                        controller: RegisterCompleteData.name,
                        action: TextInputAction.next,
                        validate: (value) =>
                            Validator(context).validateEmpty(value: value),
                      ),
                      LabelTextField(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        type: TextInputType.text,
                        label: tr(context, "password"),
                        isPassword: true,
                        controller: RegisterCompleteData.password,
                        action: TextInputAction.done,
                        onSubmit: () => RegisterCompleteData.setUserRegister(
                            context, widget.model),
                        validate: (value) =>
                            Validator(context).validatePassword(value: value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //register button
          DefaultButton(
            title: tr(context, "confirm"), //"تسجيل دخول",
            margin: EdgeInsets.all(30),
            onTap: () =>
                RegisterCompleteData.setUserRegister(context, widget.model),
          ),
        ],
      ),
    );
  }
}
