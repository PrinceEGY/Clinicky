import 'dart:async';
import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/controllers/home/home_controller.dart';
import 'package:clinicky/view/auth/login_screen.dart';
import 'package:clinicky/view/onboarding/on_boarding_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Clinicky",
                style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    fontFamily: "poppins"),
              ),
              SizedBox(height: 20),
              SpinKitThreeBounce(
                color: ColorPallete.mainColor,
                size: 100,
              ),
            ],
          )),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    var onBoardingVisited = prefs.getBool("onBoardingVisited");
    var userToken = prefs.getString("userToken");
    late Widget nextScreen;
    if (onBoardingVisited != true) {
      nextScreen = const OnBoardingScreen();
    } else if (userToken == null) {
      nextScreen = const LoginScreen();
    } else {
      BackendController().setToken();
      nextScreen = const HomeController();
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: nextScreen,
        type: PageTransitionType.fade,
      ),
    );
  }
}
