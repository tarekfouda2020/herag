import 'package:flutter/cupertino.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:flutter/material.dart';

class RichTextFiled extends StatelessWidget{

  final TextEditingController controller;
  final String label;
  final EdgeInsets margin;
  final TextInputType type;
  final int min,max;
  final double height;
  final Function(String value) validate;
  final Color fillColor;
  final bool readOnly;
  final TextInputAction action;
  final Function(String value) submit;

  RichTextFiled({
    this.label,
    this.controller,
    this.margin=const EdgeInsets.all(0),
    this.type=TextInputType.text,this.max,this.min,
    this.height,this.validate,
    this.fillColor,
    this.readOnly=false,
    this.action,
    this.submit
  });


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: height,
      margin: margin,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        textInputAction: action?? TextInputAction.done,
        onFieldSubmitted: submit,
        minLines: min,
        maxLines: max,
        readOnly: readOnly,
        style: TextStyle(fontSize: 14,fontFamily: "cairo",color: Colors.black.withOpacity(.7)),
        validator: (value)=> validate(value),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.grey.withOpacity(.5),width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: MyColors.primary,width: 2)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.grey.withOpacity(.5),width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red,width: 2)
            ),
            errorStyle: TextStyle(fontFamily: "cairo",fontSize: 10),
            hintText: "$label",
            hintStyle: TextStyle(fontFamily: "cairo",fontSize: 14),
            fillColor: fillColor?? MyColors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          filled: true
        ),
      ),
    );
  }


}