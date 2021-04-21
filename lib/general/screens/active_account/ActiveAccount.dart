import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/customer/models/Dtos/RegisterModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/general/constants/Inputs/LabelTextField.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/validator/Validator.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/HeaderLogo.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

class ActiveAccount extends StatefulWidget {
  final RegisterModel model;

  const ActiveAccount({Key key, @required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActiveAccountState();
}

class _ActiveAccountState extends State<ActiveAccount> {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController code = new TextEditingController();
  RegisterModel model;

  void setRegisterModel(RegisterModel registerModel) {
    model = registerModel;
  }

  void setActiveUser(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState.validate()) {
      if (code.text == model.code) {
        AutoRouter.of(context).push(RegisterCompleteRoute(model: model));
      } else {
        LoadingDialog.showToastNotification(tr(context, "codeValidation"));
      }
    }
  }

  void setResendCode(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    CustomerRepository(context).resendCode(model);
  }

  @override
  void initState() {
    super.initState();
    setRegisterModel(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: MyColors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
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
                        title: tr(context, "activeAccount"),
                        size: 16,
                        color: MyColors.primary,
                        alien: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: tr(context, "insertConfirmCode"),
                        size: 12,
                        color: MyColors.primary,
                        alien: TextAlign.center,
                      ),
                      LabelTextField(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        type: TextInputType.phone,
                        label: "${tr(context, "activeCode")}",
                        isPassword: false,
                        controller: code,
                        action: TextInputAction.done,
                        onSubmit: () => setActiveUser(context),
                        validate: (value) =>
                            Validator(context).validateEmpty(value: value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //register button
          DefaultButton(
            title: tr(context, "continue"), //"تسجيل دخول",
            margin: EdgeInsets.all(30),
            onTap: () => setActiveUser(context),
          ),
          //register text link
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyText(
                  title: tr(context,"neverReceiveMsg"),
                  size: 10,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () => setResendCode(context),
                    child: MyText(
                      title: tr(context, "resend"),
                      size: 10,
                      color: MyColors.primary,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
