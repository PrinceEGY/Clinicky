import 'package:clinicky/screens/appointments/create_appointment/find_clinic_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SpecialityVIew extends StatefulWidget {
  final String specialization;
  final String iconPath;
  const SpecialityVIew({
    super.key,
    required this.specialization,
    required this.iconPath,
  });

  @override
  State<SpecialityVIew> createState() => _SpecialityVIewState();
}

class _SpecialityVIewState extends State<SpecialityVIew> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        debugPrint("HI"),
        Navigator.push(
            context,
            PageTransition(
              child: ClinicPickPage(
                specialization: widget.specialization,
              ),
              type: PageTransitionType.leftToRight,
            ))
      },
      child: Column(
        children: [
          Container(
            width: 130,
            height: 130,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: ColorPallete.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              widget.iconPath,
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.specialization,
            style: const TextStyle(
                fontSize: 22,
                color: ColorPallete.mainColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
