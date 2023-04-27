import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/button.dart';
import 'package:flutter/material.dart';

class ClinicView extends StatefulWidget {
  const ClinicView({
    super.key,
    required this.clinicData,
  });

  final ClinicData clinicData;

  @override
  State<ClinicView> createState() => _ClinicViewState();
}

class _ClinicViewState extends State<ClinicView> {
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
                  onPressed: () => null,
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
