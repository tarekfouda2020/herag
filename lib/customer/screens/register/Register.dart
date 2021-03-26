import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:base_flutter/customer/models/Dtos/RegisterModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/general/constants/Inputs/LabelTextField.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/utilities/validator/Validator.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/HeaderLogo.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

import 'register_cubit/register_cubit.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>_RegisterState();

}

class _RegisterState extends State<Register>{

   final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
   final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
   final TextEditingController phone = new TextEditingController();
   final RegisterCubit registerCubit = new RegisterCubit();


   void setUserRegister(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if(formKey.currentState.validate()){
      if(!registerCubit.state.terms){
        LoadingDialog.showToastNotification("قم بالموافقة علي الشروط والأحكام");
        return;
      }
      registerCubit.onChangeLoadingState();
      RegisterModel result= await CustomerRepository(context).sendCode(phone.text);
      registerCubit.onChangeLoadingState();
      if(result!=null){
        AutoRouter.of(context).push(ActiveAccountRoute(model: result));
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: MyColors.white,
      body: BlocBuilder<RegisterCubit,RegisterState>(
          bloc: registerCubit,
          builder: (con,state){
            return IgnorePointer(
              ignoring: state.loading,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                                  title:tr(context,"register"),
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
                              children: [
                                LabelTextField(
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  type: TextInputType.phone,
                                  label: "${tr(context,"phone")}",
                                  isPassword: false,
                                  controller: phone,
                                  action: TextInputAction.done,
                                  onSubmit: ()=>setUserRegister(context),
                                  validate: (value)=> Validator(context).validatePhone(value: value),
                                ),
                                Row(
                                  children: [
                                    Checkbox(value: state.terms, onChanged: (val)=>registerCubit.onChangeTermsState()),
                                    InkWell(
                                        onTap: ()=> AutoRouter.of(context).push(TermsRoute()),
                                        child: MyText(title: "اوافق علي الشروط والأحكام",size: 10,color: MyColors.blackOpacity,)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //register button
                    Visibility(
                      child: DefaultButton(
                        title: tr(context,"continue"), //"تسجيل دخول",
                        margin: EdgeInsets.all(30),
                        onTap: ()=>setUserRegister(context),
                      ),
                      visible: !state.loading,
                      replacement: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: SpinKitDualRing(
                          color: MyColors.primary,
                          size: 30.0,
                        ),
                      ),
                    ),
                    //register text link
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          MyText(
                            title: tr(context,"haveAccount"),
                            size: 10,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: ()=>AutoRouter.of(context).pop(),
                              child: MyText(
                                title: tr(context,"login"),
                                size: 10,
                                color: MyColors.primary,
                              )),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  @override
  void dispose() {
    registerCubit.onInitialState();
    registerCubit.close();
    phone.clear();
    super.dispose();
  }
}
