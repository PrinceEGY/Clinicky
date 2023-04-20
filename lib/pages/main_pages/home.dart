import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.mainColor,
        title: const Text("Home"),
      ),
      body: const Center(
        child: Text("Home", style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
