import 'package:flutter/material.dart';

class SizeConfig {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static void init(BuildContext context){
    screenHeight=MediaQuery.of(context).size.height;
    screenWidth=MediaQuery.of(context).size.width;
  }

  static double getProportionteHeight(double inputHeight){
    return (inputHeight/812)* screenHeight;
  }
  static double getProportionteWidth(double inputWidth){
    return (inputWidth/375)* screenWidth;
  }
}