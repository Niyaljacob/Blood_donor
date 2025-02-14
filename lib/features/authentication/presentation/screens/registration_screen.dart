import 'package:donatelife/common_widgets/async_value_ui.dart';
import 'package:donatelife/common_widgets/common_button.dart';
import 'package:donatelife/common_widgets/common_text_field.dart';
import 'package:donatelife/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:donatelife/routes/routes.dart';
import 'package:donatelife/utils/appstyles.dart';
import 'package:donatelife/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  ref.listen<AsyncValue>(authControllerProvider, (_, state){
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
                  Text(
                    "${widget.type}Registration",
                    style: TextStyle(
                        fontSize: SizeConfig.getProportionteHeight(18),
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: SizeConfig.getProportionteHeight(25),
                  ),
                  CommonTextField(
                      hintText: "Enter Name...",
                      textInputType: TextInputType.text,
                      controller: _nameController),
                  SizedBox(
                    height: SizeConfig.getProportionteHeight(10),
                  ),
                  CommonTextField(
                      hintText: "Enter Phone Number...",
                      textInputType: TextInputType.number,
                      controller: _phoneController),
                  SizedBox(
                    height: SizeConfig.getProportionteHeight(10),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedBloodGroup,
                    decoration: InputDecoration(
                      labelText: 'Select Blood Group',
                      labelStyle: TextStyle(
                        fontSize: SizeConfig.getProportionteHeight(15),
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ), // BorderSide
                        borderRadius: BorderRadius.circular(20),
                      ), // Outline InputBorder
                    ), // InputDecoration
                    items: _bloodGroups.map((String group) {
                      return DropdownMenuItem<String>(
                        value: group,
                        child: Text(
                          group,
                          style: TextStyle(
                            fontSize: SizeConfig.getProportionteHeight(15),
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ), // Text
                      ); // DropdownMenuItem
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBloodGroup = newValue;
                      });
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.getProportionteHeight(10),
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
                  CommonButton(
                      onTap: () {
                        final email = _emailController.text.toString();
                        final password = _passwordController.text.toString();
                        final name = _nameController.text.toString();
                        final phoneNumber = _phoneController.text.toString();

                        ref.read(authControllerProvider.notifier)
                        .createUserWithEmailAndPassword(
                          email: email, 
                          password: password, 
                          name: name, 
                          phoneNumber: phoneNumber, 
                          bloodGroup: _selectedBloodGroup!,
                           type: widget.type);
                      }, title: "Register Me Now", isLoading: state.isLoading),
                  SizedBox(
                    height: SizeConfig.getProportionteHeight(15),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        fontSize: SizeConfig.getProportionteHeight(20),
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: SizeConfig.getProportionteHeight(15),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(
                        AppRoutes.signIn.name,
                      );
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
                        "Sign In to my account",
                        style: TextStyle(
                          fontSize: SizeConfig.getProportionteHeight(15),
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
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
      ),
    );
  }
}
