import 'package:clinicky/view/onboarding/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", "US"),
        Locale("ar", "EG"),
      ],
      locale: const Locale("ar", "EG"),
      debugShowCheckedModeBanner: false,
      title: "Clincky",
      theme: ThemeData(
        primarySwatch: ColorPallete.getMaterialColor(ColorPallete.mainColor),
        textTheme: GoogleFonts.almaraiTextTheme(),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
