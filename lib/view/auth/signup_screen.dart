import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clinicky/view/auth/login_screen.dart';
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
  final _auth = BackendController.instance;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  String? _gender;
  String? _specialization;
  String _userType = "patient";
  bool _infoIsValid = false;
  bool _isPasswordVisible = false;
  bool _isConfPasswordVisible = false;

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
              const SizedBox(height: 20),
              const Text(
                "تسجيل حساب جديد",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Lottie.asset('assets/animations/signup.json',
                  height: screenHeight * 0.4, width: screenWidth * 0.7),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "نوع الحساب:",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              CustomRadioButton(
                width: screenWidth * 0.4,
                elevation: 0,
                buttonTextStyle:
                    const ButtonTextStyle(textStyle: TextStyle(fontSize: 16)),
                absoluteZeroSpacing: true,
                defaultSelected: "patient",
                buttonLables: const ["زائر", "طبيب"],
                buttonValues: const ["patient", "doctor"],
                radioButtonValue: (value) => setState(() {
                  _userType = value;
                }),
                selectedColor: ColorPallete.mainColor,
                unSelectedColor: Colors.white,
              ),
              const SizedBox(height: 20),
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
                        labelText: "الاسم",
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _infoIsValid = false;
                          return "الرجاء ادخال اسمك";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //! Gender Field
                    DropdownButtonFormField(
                      isExpanded: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _infoIsValid = false;
                          return "الرجاء قم باختيار النوع";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "النوع",
                        prefixIcon: const Icon(Icons.person),
                      ),
                      items: ["ذكر", "انثى"]
                          .map<DropdownMenuItem<String>>((String value) =>
                              DropdownMenuItem<String>(
                                  value: value, child: Text(value)))
                          .toList(),
                      onChanged: (value) => _gender = value,
                    ),
                    if (_userType == "doctor") ...[
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        isExpanded: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _infoIsValid = false;
                            return "الرجاء قم باختيار التخصص";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "التخصص",
                          prefixIcon: const Icon(Icons.person),
                        ),
                        items: ClinicData.specialities
                            .map<DropdownMenuItem<String>>((String value) =>
                                DropdownMenuItem<String>(
                                    value: value, child: Text(value)))
                            .toList(),
                        onChanged: (value) => _specialization = value,
                      ),
                    ],
                    const SizedBox(height: 20),
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
                      validator: (value) => checkEmail(value),
                    ),
                    const SizedBox(height: 20),
                    //! Password Field
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      controller: _password,
                      textInputAction: TextInputAction.next,
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
                      validator: (value) => checkPassword(value),
                    ),
                    const SizedBox(height: 20),
                    //! Password confirmation Field
                    TextFormField(
                      obscureText: !_isConfPasswordVisible,
                      textInputAction: TextInputAction.go,
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "تأكيد كلمة السر",
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
                      validator: (value) => checkConfirmationPassword(value),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
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
                  "تسجيل الحساب",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "عندك حساب فعلا؟ ",
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
                        "سجل الدخول من هنا",
                        style: TextStyle(
                            color: ColorPallete.mainColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _validateInput() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const SpinKitCircle(
        color: Colors.white,
        size: 100,
      ),
    );
    try {
      UserData userData;
      if (_userType == "doctor") {
        userData = DoctorData(
          name: _name.text,
          password: _password.text,
          email: _email.text,
          gender: _gender!,
          specialization: _specialization!,
          type: _userType,
        );
      } else {
        userData = UserData(
          name: _name.text,
          password: _password.text,
          email: _email.text,
          gender: _gender!,
          type: _userType,
        );
      }
      await _auth.signUp(userData: userData);
      if (!mounted) return;
      showDialogMessage(
          context: context,
          text: "تم تسجيل الحساب بنجاح",
          color: ColorPallete.green);
      Navigator.pushReplacement(
          context,
          PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.rightToLeft,
          ));
    } catch (err) {
      showDialogMessage(
          context: context, text: err.toString(), color: ColorPallete.red);
      Navigator.pop(context);
    }
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

      return "الرجاء ادخال كلمة سر أكثر من 5 حروف";
    }
    return null;
  }

  String? checkConfirmationPassword(String? value) {
    if (value == null || value.isEmpty) {
      _infoIsValid = false;

      return "الرجاء ادخال كلمة سر";
    } else if (value != _password.text) {
      _infoIsValid = false;

      return "كلمة السر غير متطابقة";
    }
    return null;
  }
}
