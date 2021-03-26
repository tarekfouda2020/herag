import 'package:flutter/material.dart';
import 'package:base_flutter/general/constants/MyColors.dart';

class IconTextFiled extends StatelessWidget{

  TextEditingController controller;
  String label;
  EdgeInsets margin=EdgeInsets.all(0);
  TextInputType type=TextInputType.text;
  Widget icon;
  bool isPassword;
  Icon prefix;
  final Function(String value) validate;
  Color filledColor;
  final TextInputAction action;
  final Function(String value) submit;
  IconTextFiled({this.label,this.controller,this.margin,this.type,this.action,this.submit,
    this.icon,this.isPassword=false,this.prefix,this.filledColor,this.validate});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 75,
      margin: margin,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        enabled: true,
        obscureText: isPassword,
        textInputAction: action?? TextInputAction.done,
        onFieldSubmitted: submit,
        style: TextStyle(fontSize: 16,fontFamily: "cairo",color: Colors.black.withOpacity(.7)),
        validator: (value)=> validate(value),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.5),width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: MyColors.primary,width: 1)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.5),width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red,width: 2)
            ),
            hintText: "$label",
            hintStyle: TextStyle(fontFamily: "cairo",fontSize: 14,color: Colors.black45),
            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
          suffixIcon: icon,
          filled: true,
          fillColor: filledColor?? MyColors.white
        ),
      ),
    );
  }


}