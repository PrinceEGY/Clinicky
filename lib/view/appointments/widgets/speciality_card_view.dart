import 'package:clinicky/view/appointments/create_appointment/find_clinic_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SpecialityVIew extends StatefulWidget {
  final String specialization;
  final String iconPath;
  final double size;
  const SpecialityVIew({
    super.key,
    required this.specialization,
    required this.iconPath,
    required this.size,
  });

  @override
  State<SpecialityVIew> createState() => _SpecialityVIewState();
}

class _SpecialityVIewState extends State<SpecialityVIew> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          PageTransition(
            child: ClinicPickPage(
              specialization: widget.specialization,
            ),
            type: PageTransitionType.leftToRight,
          ),
        )
      },
      child: Column(
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: ColorPallete.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              widget.iconPath,
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
