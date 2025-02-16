import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterLottie extends StatelessWidget {
  const RegisterLottie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(
          'assets/Animation2.json',
          height: SizeConfig.getProportionteHeight(150),
        ),
      ],
    );
  }
}