import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("إشعاراتي",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        foregroundColor: ColorPallete.mainColor,
      ),
      body: const Center(
        child: Text("إشعاراتي", style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
