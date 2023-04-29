import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/controllers/home/home_controller.dart';
import 'package:clinicky/view/auth/signup_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../util/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = BackendController.instance;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  String _userType = "patient";
  bool _infoIsValid = false;
  bool _keepSignedIn = true;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "تسجيل الدخول",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Lottie.asset('assets/animations/login.json',
                  height: screenHeight * 0.4, width: screenWidth * 0.7),
              CustomRadioButton(
                width: screenWidth * 0.4,
                elevation: 0,
                buttonTextStyle:
                    const ButtonTextStyle(textStyle: TextStyle(fontSize: 16)),
                absoluteZeroSpacing: true,
                defaultSelected: "patient",
                buttonLables: const ["زائر", "طبيب"],
                buttonValues: const ["patient", "doctor"],
                radioButtonValue: (value) => {_userType = value},
                selectedColor: ColorPallete.mainColor,
                unSelectedColor: Colors.white,
              ),
              const SizedBox(height: 20),
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
                        labelText: "البريد الالكتروني",
                        prefixIcon: const Icon(Icons.email),
                      ),
                      validator: (value) {
                        return checkEmail(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    //! Password Field
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      textInputAction: TextInputAction.go,
                      controller: _password,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "كلمة السر",
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
              Row(
                children: [
                  Checkbox(
                      activeColor: ColorPallete.mainColor,
                      value: _keepSignedIn,
                      onChanged: (value) => setState(() {
                            _keepSignedIn = value!;
                          })),
                  const Text("حفظ تسجيل الدخول"),
                ],
              ),
              const SizedBox(height: 10),
              RoundedButton(
                width: double.infinity,
                height: 45,
                onPressed: () {
                  _infoIsValid = true;
                  FocusScope.of(context).unfocus();
                  _formKey.currentState!.validate();
                  if (_infoIsValid) {
                    _validateInput();
                  }
                },
                color: ColorPallete.mainColor,
                isBordered: false,
                text: const Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "معندكش حساب ؟ ",
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
                        "سجل من هنا",
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
    );
  }

  String? checkEmail(value) {
    if (value == null || value.isEmpty) {
      _infoIsValid = false;

      return "الرجاء ادخال بريد الكتروني";
    } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
      _infoIsValid = false;

      return "الرجاء ادخال بريد الكتروني صالح";
    }
    return null;
  }

  String? checkPassword(String? value) {
    if (value == null || value.isEmpty) {
      _infoIsValid = false;

      return "الرجاء ادخال كلمة سر";
    } else if (value.length < 5) {
      _infoIsValid = false;

      return "الرجاء ادخال كلمة سر اكثر من 5 حروف";
    }
    return null;
  }

  void _validateInput() async {
    final navigator = Navigator.of(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const SpinKitCircle(
        color: Colors.white,
        size: 100,
      ),
    );
    try {
      await _auth.signIn(
          email: _email.text,
          password: _password.text,
          type: _userType,
          keepSingedIn: _keepSignedIn);

      navigator.pushReplacement(
        PageTransition(
          child: const HomeController(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } catch (err) {
      showDialogMessage(
          context: context, text: err.toString(), color: ColorPallete.red);
      Navigator.pop(context);
    }
  }
}
