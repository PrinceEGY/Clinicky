import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: ColorPallete.mainColor,
      ),
      body: const Center(
        child: Text("Profile", style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
