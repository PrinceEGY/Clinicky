import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/controllers/home/home_controller.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/view/appointments/widgets/info_container.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class ConfirmationPage extends StatefulWidget {
  final ClinicData clinicData;
  final TimeOfDay selectedTimeSlot;
  final DateTime selectedDay;
  final bool isNewAppointment;
  final String oldAppointmentId;
  const ConfirmationPage({
    super.key,
    required this.clinicData,
    required this.selectedDay,
    required this.selectedTimeSlot,
    this.isNewAppointment = true,
    this.oldAppointmentId = "",
  });

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تاكيد الحجز",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          foregroundColor: ColorPallete.mainColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(20),
            color: ColorPallete.secondaryColor,
            child: Column(
              children: [
                const Text(
                  "ملخص الحجز",
                  style: TextStyle(
                    color: ColorPallete.mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Divider(
                  color: ColorPallete.mainColor,
                  thickness: 2,
                  height: 25,
                ),
                InfoContainer(
                  title: "اسم الدكتور",
                  text: "د/ ${widget.clinicData.doctorName!}",
                  icon: const Icon(Icons.person),
                ),
                InfoContainer(
                  title: "اسم العيادة",
                  text: widget.clinicData.clinicName!,
                  icon: const Icon(Icons.apartment),
                ),
                InfoContainer(
                  title: "المكان",
                  text: widget.clinicData.location!,
                  icon: const Icon(Icons.location_on),
                ),
                InfoContainer(
                  title: "سعر الكشف",
                  text: "\$${widget.clinicData.price!} جنيه",
                  icon: const Icon(Icons.attach_money),
                ),
                InfoContainer(
                  title: "معاد الحجز",
                  text:
                      "${widget.selectedTimeSlot.hour.toString().padLeft(2, "0")}:${widget.selectedTimeSlot.minute.toString().padLeft(2, "0")}\n${widget.selectedDay.toString().split(" ")[0]}",
                  icon: const Icon(Icons.timer_sharp),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _validateInput();
            },
            child: const Text(
              "تأكيد الحجز",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  _validateInput() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const SpinKitCubeGrid(
        color: ColorPallete.mainColor,
        size: 100,
      ),
    );
    try {
      String date =
          "${widget.selectedDay.toString().split(" ")[0]} ${widget.selectedTimeSlot.hour.toString().padLeft(2, "0")}:${widget.selectedTimeSlot.minute.toString().padLeft(2, "0")}";
      if (widget.isNewAppointment) {
        await BackendController.instance.addNewAppointment(
          clinicId: widget.clinicData.sId!,
          date: date,
        );
      } else {
        await BackendController.instance.updateExistingAppointmentByPatient(
          appointmentId: widget.oldAppointmentId,
          clinicId: widget.clinicData.sId!,
          date: date,
        );
      }
      if (!mounted) return;
      Navigator.pop(context);
      showConfirmationDialog();
    } catch (err) {
      Navigator.pop(context);
      showDialogMessage(
        context: context,
        text: err.toString(),
        color: ColorPallete.red,
      );
    }
  }

  void showConfirmationDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: IntrinsicHeight(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: const BoxDecoration(
                        color: ColorPallete.secondaryColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.thumb_up,
                      color: ColorPallete.mainColor,
                      size: 150,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "شكراً ليك!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "تم حجز المعاد بنجاح!",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "تم تأكيد ميعاد حجزك لتاريخ ${widget.selectedDay.toString().split(" ")[0]} الساعة ${widget.selectedTimeSlot.hour.toString().padLeft(2, "0")}:${widget.selectedTimeSlot.minute.toString().padLeft(2, "0")}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: ColorPallete.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const HomeController(),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    },
                    child: const Text(
                      "تأكيد",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
