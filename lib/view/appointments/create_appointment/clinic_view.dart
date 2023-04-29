import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/view/appointments/create_appointment/confirmation_screen.dart';
import 'package:clinicky/view/appointments/widgets/day_view.dart';
import 'package:clinicky/view/appointments/widgets/doctor_card_view.dart';
import 'package:clinicky/view/appointments/widgets/info_container.dart';
import 'package:clinicky/view/appointments/widgets/time_slot.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class PatientClinicViewPage extends StatefulWidget {
  final String clinicID;
  final bool isNewAppointment;
  final String oldAppointmentId;
  const PatientClinicViewPage({
    super.key,
    required this.clinicID,
    this.isNewAppointment = true,
    this.oldAppointmentId = "",
  });

  @override
  State<PatientClinicViewPage> createState() => _PatientClinicViewPageState();
}

class _PatientClinicViewPageState extends State<PatientClinicViewPage> {
  late ClinicData clinicData;
  late Future<ClinicData> futureClinicData;
  final dayData = {
    1: "الإثنين",
    2: "الثلاثاء",
    3: "الأربعاء",
    4: "الخميس",
    5: "الجمعة",
    6: "السبت",
    7: "الأحد"
  };
  bool _isFavourite = false;
  DateTime? selectedDay;
  TimeOfDay? selectedTimeSlot;
  @override
  void initState() {
    super.initState();
    futureClinicData = BackendController.instance
        .getClinicDetailsById(clinicId: widget.clinicID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: futureClinicData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            clinicData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    iconSize: 30,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    splashRadius: 10,
                    onPressed: () => setState(() {
                      _isFavourite = !_isFavourite;
                    }),
                    icon: Icon(
                      _isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: ColorPallete.red,
                    ),
                  ),
                ],
                title: const Text("معلومات العيادة",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                foregroundColor: ColorPallete.mainColor,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorCardView(clinicData: clinicData),
                    InfoContainer(
                      title: "اسم العيادة",
                      text: clinicData.clinicName!,
                      icon: const Icon(Icons.apartment),
                    ),
                    InfoContainer(
                      title: "المكان",
                      text: clinicData.location!,
                      icon: const Icon(Icons.location_on),
                    ),
                    InfoContainer(
                      title: "سعر الكشف",
                      text: "\$${clinicData.price!} جنيه",
                      icon: const Icon(Icons.attach_money),
                    ),
                    InfoContainer(
                      title: "رقم العيادة",
                      text: clinicData.phone!,
                      icon: const Icon(Icons.phone),
                    ),
                    InfoContainer(
                      title: "وصف العيادة",
                      text: clinicData.about!,
                      icon: const Icon(Icons.description),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 5),
                      child: Text(
                        "اختار موعدك المناسب",
                        style: TextStyle(
                          color: ColorPallete.grey,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: getDates(clinicData),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 10,
                        alignment: WrapAlignment.spaceEvenly,
                        children: clinicData.availableTimeSlots!
                            .map(
                              (value) => TimeSlot(
                                isSelected: value == selectedTimeSlot,
                                time: value!,
                                onChange: () => setState(() {
                                  selectedTimeSlot = value;
                                }),
                                isActive: selectedDay == null
                                    ? false
                                    : clinicData.isSlotAvailable(
                                        selectedDay!, value),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    // const SizedBox(height: 100),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12)),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (selectedDay == null || selectedTimeSlot == null) {
                      showDialogMessage(
                        context: context,
                        text: "الرجاء اختيار موعد",
                        color: ColorPallete.red,
                      );
                    } else {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: ConfirmationPage(
                              clinicData: clinicData,
                              selectedDay: selectedDay!,
                              selectedTimeSlot: selectedTimeSlot!,
                              isNewAppointment: widget.isNewAppointment,
                              oldAppointmentId: widget.oldAppointmentId,
                            ),
                            type: PageTransitionType.leftToRight,
                          ));
                    }
                  },
                  child: const Text(
                    "حجز الموعد",
                    style: TextStyle(fontSize: 18),
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

  List<Widget> getDates(ClinicData clinicData) {
    var dayMap = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      7: "Sunday"
    };

    List<Widget> dates = [];
    for (int i = 0; i < 30; i++) {
      var currentDay = DateTime.now().add(Duration(days: i));
      dates.add(
        DayView(
          day: dayData[currentDay.weekday]!,
          dayNumber: "${currentDay.day} / ${currentDay.month}",
          onTap: () {
            setState(() {
              selectedDay = currentDay;
              selectedTimeSlot = null;
            });
          },
          isChosen: selectedDay == null
              ? false
              : (selectedDay?.day == currentDay.day) &&
                  (selectedDay!.month == currentDay.month),
          isAvailable:
              clinicData.availableDays!.contains(dayMap[currentDay.weekday]),
        ),
      );
    }
    return dates;
  }
}
