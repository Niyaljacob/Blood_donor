
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';


class Appstyles {
  static final headingTextStyle = TextStyle(
    fontSize: SizeConfig.getProportionteHeight(20),
    color: Colors.white,
    fontWeight: FontWeight.bold
  );


   static final titleTextStyle = TextStyle(
    fontSize: SizeConfig.getProportionteHeight(18),
    color: Colors.black,
    fontWeight: FontWeight.w600
  );

   static final normalTextStyle = TextStyle(
    fontSize: SizeConfig.getProportionteHeight(15),
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static const mainColor = Color.fromARGB(255, 207, 101, 101);
}