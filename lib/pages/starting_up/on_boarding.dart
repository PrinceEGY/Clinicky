import 'package:clinicky/pages/starting_up/login.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OnBoardingSlider(
        finishButtonText: "Get Started",
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: ColorPallete.mainColor,
        ),
        skipTextButton: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 20,
            color: ColorPallete.mainColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onFinish: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: const Duration(milliseconds: 500),
                  child: const LoginScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        controllerColor: ColorPallete.mainColor,
        background: [
          Lottie.asset('assets/animations/booking.json',
              height: 400, width: 400),
          Lottie.asset('assets/animations/find_clinic.json',
              height: 400, width: 400),
          Lottie.asset('assets/animations/login.json', height: 400, width: 400),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: const [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Appointments Booking',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Book appointment easily in few mintues',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: const [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Find nearby clinics',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Find out best nearby clinics that suits your needs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: const [
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Start Now!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Click below to get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
