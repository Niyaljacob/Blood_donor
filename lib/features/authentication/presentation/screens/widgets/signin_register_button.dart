import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInRegisterButton extends StatelessWidget {
  const SignInRegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(AppRoutes.signIn.name);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Appstyles.mainColor,
            width: 2,
          ),
        ),
        child: Text(
          "Sign In to my account",
          style: TextStyle(
            fontSize: SizeConfig.getProportionteHeight(15),
            color: Appstyles.mainColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}


