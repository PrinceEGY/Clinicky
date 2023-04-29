import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class DoctorCardView extends StatelessWidget {
  const DoctorCardView({
    super.key,
    required this.clinicData,
  });

  final ClinicData clinicData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      color: ColorPallete.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/male.png"),
            ),
            const SizedBox(width: 10),
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "د/ ${clinicData.doctorName!}",
                    style: const TextStyle(
                      color: ColorPallete.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: ColorPallete.mainColor,
                    thickness: 2,
                  ),
                  Text(
                    clinicData.specialization!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
