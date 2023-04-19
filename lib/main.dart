import 'package:clinkcy_local/pages/login.dart';
import 'package:clinkcy_local/pages/on_boarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Clincky",
      home: OnBoard(),
    );
  }
}
