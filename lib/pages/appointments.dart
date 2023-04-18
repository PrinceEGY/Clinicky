import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
      ),
      body: const Center(
        child: Text("Appointments", style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
