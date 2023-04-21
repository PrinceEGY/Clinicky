import 'package:clinicky/screens/onboarding/on_boarding_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      title: "Clincky",
      theme: ThemeData(
        primarySwatch: ColorPallete.getMaterialColor(ColorPallete.mainColor),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const OnBoard(),
    );
  }
}
