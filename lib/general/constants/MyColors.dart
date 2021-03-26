import 'dart:ui';
import 'package:flutter/material.dart';

class MyColors{
  static Color primary =  Color(0xff005b9f);
  static Color secondary =  Colors.black;
  static Color gold=Color(0xffe4aa69);
  static Color grey=Colors.grey;
  static Color greyWhite=Colors.grey.withOpacity(.2);
  static Color black=Color(0xff313135);
  static Color blackOpacity=Colors.black54;
  static Color white=Colors.white;
  static Color greenColor=Colors.green;
  static Color notifyColor=Colors.black54;


  static setColors({Color primaryColor,Color secondaryColor}){
    primary=primaryColor;
    secondary=secondaryColor;
  }

}