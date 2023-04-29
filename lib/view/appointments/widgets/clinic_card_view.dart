import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/view/appointments/create_appointment/clinic_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ClinicViewPatient extends StatefulWidget {
  final ClinicData clinicData;
  const ClinicViewPatient({
    required this.clinicData,
    super.key,
  });

  @override
  State<ClinicViewPatient> createState() => _ClinicViewPatientState();
}

class _ClinicViewPatientState extends State<ClinicViewPatient> {
  bool _isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          PageTransition(
            child: PatientClinicViewPage(
              clinicID: widget.clinicData.sId!,
            ),
            type: PageTransitionType.leftToRight,
          ),
        )
      },
      child: Stack(
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 10),
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: ColorPallete.mainColor),
            ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.clinicData.clinicName!,
                        style: const TextStyle(
                          color: ColorPallete.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "د/ ${widget.clinicData.doctorName!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.clinicData.location!,
                        style: const TextStyle(
                          color: ColorPallete.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              splashRadius: 10,
              onPressed: () => setState(() {
                _isFavourite = !_isFavourite;
              }),
              icon: Icon(
                _isFavourite ? Icons.favorite : Icons.favorite_border,
                color: ColorPallete.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
