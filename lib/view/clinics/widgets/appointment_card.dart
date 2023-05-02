import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:clinicky/view/appointments/create_appointment/clinic_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class AppointmentClinicCard extends StatefulWidget {
  const AppointmentClinicCard({
    super.key,
    required this.appointmentData,
  });

  final AppointmentData appointmentData;

  @override
  State<AppointmentClinicCard> createState() => _AppointmentClinicCardState();
}

class _AppointmentClinicCardState extends State<AppointmentClinicCard> {
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
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * .35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.appointmentData.patientName!,
                            style: const TextStyle(
                              color: ColorPallete.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
                        text: const Text("إتمام الحجز"),
                        onPressed: () {
                          updateAppointmentDialog(
                              text: "هل تم الموعد بنجاح وتريد اغلاقه؟",
                              status: "COMPLETED");
                        },
                        width: screenWidth * 0.38,
                      ),
                      RoundedButton(
                        isBordered: true,
                        text: const Text("الغاء الحجز"),
                        onPressed: () {
                          updateAppointmentDialog(
                              text: "هل انت متاكد انك تريد الغاء الحجز؟",
                              status: "CANCELED");
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

  void updateAppointmentDialog({required String text, required String status}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedButton(
                        text: const Text(
                          "تأكيد",
                        ),
                        onPressed: () {
                          updateAppointmentStatus(status: status);
                        },
                        color: ColorPallete.red,
                      ),
                      const SizedBox(width: 10),
                      RoundedButton(
                        text: const Text(
                          "الغاء",
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: ColorPallete.mainColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void updateAppointmentStatus({required status}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const SpinKitCubeGrid(
        color: ColorPallete.mainColor,
        size: 100,
      ),
    );
    try {
      await BackendController.instance.updateAppointmentStatusByIdClinic(
        appointmentData: widget.appointmentData,
        newStatus: status,
      );
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pop(context);
      showDialogMessage(
          context: context,
          text: "تمت العملية بنجاح",
          color: ColorPallete.green);
      setState(() {});
    } catch (err) {
      Navigator.pop(context);
      showDialogMessage(
        context: context,
        text: err.toString(),
        color: ColorPallete.red,
      );
    }
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
