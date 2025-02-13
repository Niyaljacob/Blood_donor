import 'package:donatelife/common_widgets/common_button.dart';
import 'package:donatelife/common_widgets/common_text_field.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyles.mainColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.getProportionteWidth(10),
            SizeConfig.getProportionteHeight(50),
            SizeConfig.getProportionteWidth(10),
            0),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Image.asset(
                  'assets/unnamed.png',
                  fit: BoxFit.cover,
                ),
                Text("Sign In to your account"),
                SizedBox(
                  height: SizeConfig.getProportionteHeight(25),
                ),
                CommonTextField(
                    hintText: "Enter Email...",
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController),
                SizedBox(
                  height: SizeConfig.getProportionteHeight(10),
                ),
                CommonTextField(
                    hintText: "Enter Password...",
                    textInputType: TextInputType.text,
                    controller: _passwordController),
                SizedBox(
                  height: SizeConfig.getProportionteHeight(10),
                ),
                CommonButton(onTap: () {}, title: "Sign in", isLoading: false),
                SizedBox(
                  height: SizeConfig.getProportionteHeight(15),
                ),
                Text(
                  "QR",
                  style: Appstyles.titleTextStyle.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: SizeConfig.getProportionteHeight(15),
                ),
                GestureDetector(
                  onTap: () {
                    context.goNamed(AppRoutes.register.name,
                        extra: "Recipient");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid,
                        )),
                    child: Text(
                      "Register as Recipient",
                      style: Appstyles.normalTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.getProportionteHeight(10),
                ),
                GestureDetector(
                  onTap: () {
                    context.goNamed(AppRoutes.register.name, extra: "Donor");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid,
                        )),
                    child: Text(
                      "Register as Donor",
                      style: Appstyles.normalTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.getProportionteHeight(10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
