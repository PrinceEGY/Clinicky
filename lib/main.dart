import 'package:clinicky/screens/onboarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      title: "Clincky",
      home: OnBoard(),
    );
  }
}
