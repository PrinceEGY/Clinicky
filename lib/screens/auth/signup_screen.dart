import 'package:clinicky/backend_handler.dart';
import 'package:clinicky/home_handler/home_handler.dart';
import 'package:clinicky/screens/auth/login_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../util/widgets/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = BackendHandler.instance;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  String? _gender;
  String _userType = "Patient";
  bool _isPasswordVisible = false;
  bool _isConfPasswordVisible = false;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset('assets/animations/signup.json',
                    height: screenHeight * 0.4, width: screenWidth * 0.7),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //! Name Field
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Name",
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          return value!.isEmpty ? "Please enter a name" : null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //! Gender Field
                      DropdownButtonFormField(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Gender",
                          prefixIcon: const Icon(Icons.person),
                        ),
                        items: ["Male", "Female"]
                            .map<DropdownMenuItem<String>>((String value) =>
                                DropdownMenuItem<String>(
                                    value: value, child: Text(value)))
                            .toList(),
                        onChanged: (value) => _gender = value,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                        controller: _password,
                        textInputAction: TextInputAction.next,
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
                      const SizedBox(
                        height: 20,
                      ),
                      //! Password confirmation Field
                      TextFormField(
                        obscureText: !_isConfPasswordVisible,
                        textInputAction: TextInputAction.go,
                        controller: _confirmPassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Confirm password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isConfPasswordVisible =
                                        !_isConfPasswordVisible;
                                  });
                                },
                                icon: Icon(_isConfPasswordVisible != true
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        validator: (value) {
                          return checkConfirmationPassword(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                CustomRadioButton(
                  width: screenWidth * 0.4,
                  elevation: 0,
                  buttonTextStyle:
                      const ButtonTextStyle(textStyle: TextStyle(fontSize: 16)),
                  absoluteZeroSpacing: true,
                  defaultSelected: "Patient",
                  buttonLables: const ["Patient", "Doctor"],
                  buttonValues: const ["Patient", "Doctor"],
                  radioButtonValue: (value) => {_userType = value},
                  selectedColor: ColorPallete.mainColor,
                  unSelectedColor: Colors.white,
                ),
                const SizedBox(
                  height: 20,
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
                    "Sign Up",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Already have an account? ",
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
                              child: const LoginScreen(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
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
    );
  }

  void _validateInput() {
    var response = _auth.signUp(
      name: _name.text,
      gender: _gender,
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

  String? checkConfirmationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 5) {
      return "Enter valid Password";
    } else if (value != _password.text) {
      return "Password didn't match";
    }
    return null;
  }
}
