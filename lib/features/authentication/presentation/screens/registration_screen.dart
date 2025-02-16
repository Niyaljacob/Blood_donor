import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/common_button.dart';
import 'package:donatelife/common_widgets/common_text_field.dart';
import 'package:donatelife/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:donatelife/features/authentication/presentation/screens/widgets/registration_lottie.dart';
import 'package:donatelife/features/authentication/presentation/screens/widgets/signin_register_button.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen(this.type, {super.key});
  final String type;
  @override
  ConsumerState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedBloodGroup;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RegisterLottie(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionteWidth(20),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.getProportionteHeight(20)),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.type} Registration",
                        style: TextStyle(
                          fontSize: SizeConfig.getProportionteHeight(20),
                          fontWeight: FontWeight.bold,
                          color: Appstyles.mainColor,
                        ),
                      ),
                      SizedBox(height: SizeConfig.getProportionteHeight(20)),
                      CommonTextField(
                        hintText: "Enter Name...",
                        textInputType: TextInputType.text,
                        controller: _nameController,
                      ),
                      SizedBox(height: SizeConfig.getProportionteHeight(10)),
                      CommonTextField(
                        hintText: "Enter Phone Number...",
                        textInputType: TextInputType.number,
                        controller: _phoneController,
                      ),
                      SizedBox(height: SizeConfig.getProportionteHeight(10)),
                      DropdownButtonFormField<String>(
                        value: _selectedBloodGroup,
                        decoration: InputDecoration(
                          labelText: 'Select Blood Group',
                          labelStyle: TextStyle(
                            fontSize: SizeConfig.getProportionteHeight(15),
                            color: Appstyles.mainColor,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        items: _bloodGroups.map((String group) {
                          return DropdownMenuItem<String>(
                            value: group,
                            child: Text(
                              group,
                              style: TextStyle(
                                fontSize: SizeConfig.getProportionteHeight(15),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBloodGroup = newValue;
                          });
                        },
                      ),
                      SizedBox(height: SizeConfig.getProportionteHeight(10)),
                      CommonTextField(
                        hintText: "Enter Email...",
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      SizedBox(height: SizeConfig.getProportionteHeight(10)),
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
                          final name = _nameController.text.toString();
                          final phoneNumber = _phoneController.text.toString();

                          ref
                              .read(authControllerProvider.notifier)
                              .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                                name: name,
                                phoneNumber: phoneNumber,
                                bloodGroup: _selectedBloodGroup!,
                                type: widget.type,
                              )
                              .then((_) {
                            // Navigate to the Sign In screen after successful registration
                            context.goNamed(AppRoutes.signIn.name);
                          }).catchError((error) {
                            // Handle the error if the registration fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Registration failed: $error')),
                            );
                          });
                        },
                        title: "Register Me Now",
                        isLoading: state.isLoading,
                      ),
                      SizedBox(height: SizeConfig.getProportionteHeight(15)),
                      Text(
                        "OR",
                        style: TextStyle(
                          fontSize: SizeConfig.getProportionteHeight(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.getProportionteHeight(15)),
                      SignInRegisterButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

