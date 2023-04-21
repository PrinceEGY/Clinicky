import 'package:clinicky/backend_handler.dart';
import 'package:clinicky/home_handler/home_handler.dart';
import 'package:clinicky/screens/auth/signup_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../util/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = BackendHandler.instance;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _userType = "Patient";

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: screenHeight * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Lottie.asset('assets/animations/login.json',
                      height: screenHeight * 0.4, width: screenWidth * 0.7),
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //! Email Field
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: _email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Email address",
                            prefixIcon: const Icon(Icons.email),
                          ),
                          validator: (value) {
                            return checkEmail(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //! Password Field
                        TextFormField(
                          obscureText: !_isPasswordVisible,
                          textInputAction: TextInputAction.go,
                          controller: _password,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(_isPasswordVisible != true
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          validator: (value) {
                            return checkPassword(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  CustomRadioButton(
                    width: screenWidth * 0.4,
                    elevation: 0,
                    buttonTextStyle: const ButtonTextStyle(
                        textStyle: TextStyle(fontSize: 16)),
                    absoluteZeroSpacing: true,
                    defaultSelected: "Patient",
                    buttonLables: const ["Patient", "Doctor"],
                    buttonValues: const ["Patient", "Doctor"],
                    radioButtonValue: (value) => {_userType = value},
                    selectedColor: ColorPallete.mainColor,
                    unSelectedColor: Colors.white,
                  ),
                  RoundedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _formKey.currentState!.validate();
                      _validateInput();
                    },
                    color: ColorPallete.mainColor,
                    isBordered: false,
                    text: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: ColorPallete.mainColor),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: const SignupScreen(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: ColorPallete.mainColor,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateInput() {
    var response = _auth.signIn(
      email: _email.text,
      password: _password.text,
      type: _userType,
    );
    if (response == 200) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const HomeHandler(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } else {
      showErrorMessage(
          context: context, text: "Invalid Password or Email address");
    }
  }

  String? checkEmail(value) {
    if (value == null || value.isEmpty) {
      return "Enter Email";
    } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
      return "Enter valid Email";
    }
    return null;
  }

  String? checkPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 5) {
      return "Enter valid Password";
    }
    return null;
  }
}
