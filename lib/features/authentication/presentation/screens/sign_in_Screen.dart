import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/common_button.dart';
import 'package:donatelife/common_widgets/common_text_field.dart';
import 'package:donatelife/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:donatelife/features/authentication/presentation/screens/widgets/animation_button.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

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
    SizeConfig.init(context);

    final state = ref.watch(authControllerProvider);

    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Appstyles.mainColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeConfig.getProportionteWidth(10),
              SizeConfig.getProportionteHeight(50),
              SizeConfig.getProportionteWidth(10),
              0),
          child: SingleChildScrollView(
            child: FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    BounceInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Image.asset(
                        'assets/unnamed.png',
                        fit: BoxFit.cover,
                        height: SizeConfig.getProportionteHeight(150),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Sign In to your account",
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: SizeConfig.getProportionteHeight(25)),
                    CommonTextField(
                      hintText: "Enter Email...",
                      textInputType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    SizedBox(height: SizeConfig.getProportionteHeight(20)),
                    CommonTextField(
                      hintText: "Enter Password...",
                      textInputType: TextInputType.text,
                      controller: _passwordController,
                    ),
                    SizedBox(height: SizeConfig.getProportionteHeight(20)),
                    CommonButton(
                      onTap: () {
                        final email = _emailController.text.toString();
                        final password = _passwordController.text.toString();
                        ref
                            .read(authControllerProvider.notifier)
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                      },
                      title: "Sign in",
                      isLoading: state.isLoading,
                    ),
                    SizedBox(height: SizeConfig.getProportionteHeight(25)),
                    Text(
                      "OR",
                      style: TextStyle(
                        fontSize: SizeConfig.getProportionteHeight(20),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.getProportionteHeight(20)),
                    buildAnimatedButton(
                      context,
                      "Register as Recipient",
                      Colors.pinkAccent,
                      Icons.person,
                      onTap: () {
                        context.goNamed(AppRoutes.register.name, extra: "Recipient");
                      },
                    ),
                    SizedBox(height: SizeConfig.getProportionteHeight(15)),
                    buildAnimatedButton(
                      context,
                      "Register as Donor",
                      Colors.blueAccent,
                      Icons.favorite,
                      onTap: () {
                        context.goNamed(AppRoutes.register.name, extra: "Donor");
                      },
                    ),
                    SizedBox(height: SizeConfig.getProportionteHeight(10)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}

  