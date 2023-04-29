import 'package:clinicky/view/auth/signup_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  _storeOnBoardPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onBoardingVisited", true);
  }

  @override
  void initState() {
    super.initState();
    _storeOnBoardPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OnBoardingSlider(
        centerBackground: true,
        finishButtonText: "ابدأ الآن",
        finishButtonStyle:
            const FinishButtonStyle(backgroundColor: ColorPallete.mainColor),
        skipTextButton: const Text(
          'تخطي',
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
                  child: const SignupScreen(),
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
                  'احجز عيادتك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'احجز عيادتك بسهولة في دقائق',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 20,
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
                  'دور على أقرب عيادة ليك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'شوف فين اقرب عيادة مناسبة لاحتياجاتك وبانسب سعر ومواصفات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 480),
                const Text(
                  'ابدأ دلوقتي !!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'اضغط على الزر عشان تبدأ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 100),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
