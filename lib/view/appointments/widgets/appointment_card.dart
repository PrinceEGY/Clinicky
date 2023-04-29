import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/view/appointments/appointment_view/appointment_view.dart';
import 'package:clinicky/view/appointments/create_appointment/clinic_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({
    super.key,
    required this.appointmentData,
  });

  final AppointmentData appointmentData;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  RoundedButton(
                    text: Text(_getStatusText(widget.appointmentData.status!)),
                    isBordered: true,
                    onPressed: () => null,
                    color: _getStatusColor(widget.appointmentData.status!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.appointmentData.appointmentDate!.split(" ")[0],
                    style: const TextStyle(
                      color: ColorPallete.grey,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.appointmentData.appointmentDate!.split(" ")[1],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/male.png"),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: PatientClinicViewPage(
                                clinicID: widget.appointmentData.clinicId!,
                              ),
                              type: PageTransitionType.leftToRight,
                            ),
                          ),
                          child: Text(
                            widget.appointmentData.clinicName!,
                            style: const TextStyle(
                              color: ColorPallete.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "د/ ${widget.appointmentData.doctorName!}",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.appointmentData.specialization!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.appointmentData.location!,
                          style: const TextStyle(
                            color: ColorPallete.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.appointmentData.status ==
                    AppointmentStatus.pending) ...[
                  const Divider(
                    color: ColorPallete.mainColor,
                    height: 25,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedButton(
                        text: const Text("عرض الحجز"),
                        onPressed: () => Navigator.push(
                          context,
                          PageTransition(
                            child: AppointmentView(
                              appointmentId: widget.appointmentData.sId!,
                            ),
                            type: PageTransitionType.leftToRight,
                          ),
                        ),
                        width: screenWidth * 0.38,
                      ),
                      RoundedButton(
                        isBordered: true,
                        text: const Text("اعادة الجدولة"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: PatientClinicViewPage(
                                clinicID: widget.appointmentData.clinicId!,
                                isNewAppointment: false,
                                oldAppointmentId: widget.appointmentData.sId!,
                              ),
                              type: PageTransitionType.leftToRight,
                            ),
                          );
                        },
                        width: screenWidth * 0.38,
                        color: ColorPallete.red,
                      ),
                    ],
                  )
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(AppointmentStatus appointmentStatus) {
    if (appointmentStatus == AppointmentStatus.canceled) {
      return "ملغي";
    } else if (appointmentStatus == AppointmentStatus.completed) {
      return "مكتمل";
    } else if (appointmentStatus == AppointmentStatus.passed) {
      return "فائت";
    } else {
      return "مؤكد";
    }
  }

  Color _getStatusColor(AppointmentStatus appointmentStatus) {
    if (appointmentStatus == AppointmentStatus.canceled) {
      return ColorPallete.red;
    } else if (appointmentStatus == AppointmentStatus.completed) {
      return ColorPallete.green;
    } else if (appointmentStatus == AppointmentStatus.passed) {
      return ColorPallete.red;
    } else {
      return ColorPallete.mainColor;
    }
  }
}
