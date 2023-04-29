import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:clinicky/view/appointments/widgets/appointment_card.dart';
import 'package:clinicky/view/appointments/widgets/speciality_card_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePagePatient extends StatefulWidget {
  const HomePagePatient({super.key});

  @override
  State<HomePagePatient> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  final request = BackendController.instance;
  late Future<UserData> futureUserData;
  late List<AppointmentData>? appointmentsData;
  late Future<List<AppointmentData>?> futureAppointmentsData;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUserData = request.getUserInfo();
    futureAppointmentsData =
        BackendController.instance.getAllAppointmentsPatient();
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: Future.wait([futureUserData, futureAppointmentsData]),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          UserData userData = snapshot.data[0];
          appointmentsData = snapshot.data[1];
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(userData.gender == "ذكر"
                              ? "assets/images/male.png"
                              : "assets/images/female.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("أهلا بيك \u{1F44B}"),
                            Text(
                              userData.name!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "إبحث من هنا",
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "الحجوزات القادمة",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (snapshot.data[1] != null &&
                        _getUpcomingAppoointment() != null)
                      AppointmentCard(
                          appointmentData: _getUpcomingAppoointment()!)
                    else
                      const Center(
                        child: Card(
                          color: Color.fromARGB(255, 254, 180, 190),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "لا يوجد لديك حجوزات قادمة\n قم بحجز موعد جديد من الزر بمنتصف الشاشة",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    const Text(
                      "التخصصات",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    IntrinsicWidth(
                      child: Wrap(
                        runSpacing: 30,
                        alignment: WrapAlignment.spaceAround,
                        children: ClinicData.specialities
                            .sublist(0, 6)
                            .map(
                              (value) => SpecialityVIew(
                                size: 90,
                                specialization: value,
                                iconPath:
                                    "assets/images/speciality_icons/clinic.png",
                              ),
                            )
                            .toList(),
                      ),
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
    );
  }

  AppointmentData? _getUpcomingAppoointment() {
    for (var appointment in appointmentsData!.reversed) {
      if (appointment.status == AppointmentStatus.pending) return appointment;
    }
    return null;
  }
}
