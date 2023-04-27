import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class CreateAppointmentPage extends StatelessWidget {
  const CreateAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("إنشاء موعد جديد",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          foregroundColor: ColorPallete.mainColor,
        ),
        body: const Center(
          child: Text("إنشاء موعد جديد", style: TextStyle(fontSize: 40)),
        ),
      ),
    );
  }
}
