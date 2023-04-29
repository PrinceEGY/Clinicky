import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/controllers/home/home_controller.dart';
import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/util/widgets/button.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:clinicky/view/appointments/create_appointment/clinic_view.dart';
import 'package:clinicky/view/appointments/widgets/info_container.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class AppointmentView extends StatefulWidget {
  final String appointmentId;
  const AppointmentView({
    super.key,
    required this.appointmentId,
  });

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  late AppointmentData appointmentData;
  late Future<AppointmentData> futureAppointmentData;
  @override
  void initState() {
    super.initState();
    futureAppointmentData = BackendController.instance
        .getAppointmentById(appointmentId: widget.appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: futureAppointmentData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            appointmentData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text("عرض الحجز",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                        text: "د/ ${appointmentData.doctorName}",
                        icon: const Icon(Icons.person),
                      ),
                      InfoContainer(
                        title: "اسم العيادة",
                        text: appointmentData.clinicName!,
                        icon: const Icon(Icons.apartment),
                      ),
                      InfoContainer(
                        title: "المكان",
                        text: appointmentData.location!,
                        icon: const Icon(Icons.location_on),
                      ),
                      InfoContainer(
                        title: "سعر الكشف",
                        text: "\$${appointmentData.price!} جنيه",
                        icon: const Icon(Icons.attach_money),
                      ),
                      InfoContainer(
                        title: "معاد الحجز",
                        text:
                            "${appointmentData.appointmentDate!.split(" ")[1]}\n${appointmentData.appointmentDate!.split(" ")[0]}",
                        icon: const Icon(Icons.timer_sharp),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedButton(
                            text: const Text("اعادة الجدولة"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: PatientClinicViewPage(
                                    clinicID: appointmentData.clinicId!,
                                    isNewAppointment: false,
                                    oldAppointmentId: appointmentData.sId!,
                                  ),
                                  type: PageTransitionType.leftToRight,
                                ),
                              );
                            },
                            width: MediaQuery.of(context).size.width * 0.38,
                            color: ColorPallete.mainColor,
                          ),
                          const SizedBox(width: 10),
                          RoundedButton(
                            isBordered: true,
                            text: const Text("الغاء الحجز"),
                            onPressed: () {
                              deleteAppointmentDialog();
                            },
                            width: MediaQuery.of(context).size.width * 0.38,
                            color: ColorPallete.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
                child: SpinKitCubeGrid(
              color: ColorPallete.mainColor,
              size: 100,
            ));
          }
        },
      ),
    );
  }

  void deleteAppointmentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Text(
                    "هل انت متأكد انك تريد الغاء الحجز؟",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedButton(
                        text: const Text(
                          "تأكيد الالغاء",
                        ),
                        onPressed: () {
                          deleteAppointment();
                        },
                        color: ColorPallete.red,
                      ),
                      const SizedBox(width: 10),
                      RoundedButton(
                        text: const Text(
                          "عدم الإلغاء",
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

  void deleteAppointment() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const SpinKitCubeGrid(
        color: ColorPallete.mainColor,
        size: 100,
      ),
    );
    try {
      await BackendController.instance.updateAppointmentStatusByIdPatient(
        appointmentData: appointmentData,
        newStatus: "CANCELED",
      );
      if (!mounted) return;
      Navigator.pop(context);
      showDialogMessage(
          context: context,
          text: "تم الغاء الحجز بنجاح",
          color: ColorPallete.green);
      Navigator.pushReplacement(
          context,
          PageTransition(
            child: const HomeController(),
            type: PageTransitionType.rightToLeft,
          ));
    } catch (err) {
      Navigator.pop(context);
      showDialogMessage(
        context: context,
        text: err.toString(),
        color: ColorPallete.red,
      );
    }
  }
}
