import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/button.dart';
import 'package:clinicky/view/clinics/clinic_appointments_view/clinic_appointments_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ClinicCard extends StatefulWidget {
  const ClinicCard({
    super.key,
    required this.clinicData,
  });

  final ClinicData clinicData;

  @override
  State<ClinicCard> createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: ColorPallete.mainColor),
      ),
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      color: ColorPallete.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: ColorPallete.mainColor,
                  radius: 35,
                  child: Icon(
                    color: Colors.white,
                    Icons.apartment,
                    size: 45,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.clinicData.clinicName!,
                      style: const TextStyle(
                          color: ColorPallete.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.clinicData.location!,
                      style: const TextStyle(
                        color: ColorPallete.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: ColorPallete.mainColor,
              height: 25,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  text: const Text("عرض الحجوزات"),
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                      child: ClinicAppointmentViewPage(
                        clinicID: widget.clinicData.sId!,
                      ),
                      type: PageTransitionType.leftToRight,
                    ),
                  ),
                  width: screenWidth * 0.38,
                ),
                RoundedButton(
                  isBordered: true,
                  text: const Text("تعديل العيادة"),
                  onPressed: () => null,
                  width: screenWidth * 0.38,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
