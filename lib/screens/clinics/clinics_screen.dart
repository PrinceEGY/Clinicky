import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("عياداتي",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        foregroundColor: ColorPallete.mainColor,
      ),
      body: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: screenWidth,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}