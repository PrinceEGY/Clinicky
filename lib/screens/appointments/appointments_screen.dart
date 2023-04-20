import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        backgroundColor: ColorPallete.mainColor,
      ),
      body: const Center(
        child: Text("Appointments", style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
