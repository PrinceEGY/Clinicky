import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/screens/appointments/widgets/speciality_card_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class SpecialityPickPage extends StatelessWidget {
  const SpecialityPickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("إنشاء موعد جديد",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          foregroundColor: ColorPallete.mainColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "التخصص",
                  style: TextStyle(
                      fontSize: 24,
                      color: ColorPallete.mainColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                IntrinsicWidth(
                  child: Wrap(
                    runSpacing: 30,
                    alignment: WrapAlignment.spaceAround,
                    children: ClinicData.specialities
                        .map((value) => SpecialityVIew(
                            specialization: value,
                            iconPath:
                                "assets/images/speciality_icons/tooth.png"))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
