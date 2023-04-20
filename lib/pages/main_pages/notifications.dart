import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: ColorPallete.mainColor,
      ),
      body: const Center(
        child: Text("Notifications", style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
