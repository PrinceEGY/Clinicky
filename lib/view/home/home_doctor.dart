import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:clinicky/view/appointments/widgets/appointment_card.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/view/clinics/widgets/clinic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePageDoctor extends StatefulWidget {
  const HomePageDoctor({super.key});

  @override
  State<HomePageDoctor> createState() => _HomePageDoctorState();
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  final request = BackendController.instance;
  late Future<UserData> futureUserData;
  late Future<List<ClinicData>?> futureClinicsData;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUserData = request.getUserInfo();
    futureClinicsData = BackendController.instance.getDoctorClinics();
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: Future.wait([futureUserData, futureClinicsData]),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          UserData userData = snapshot.data[0];
          List<ClinicData>? clinicsData = snapshot.data[1];
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
                      "عياداتي",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (snapshot.data[1] != null)
                      ClinicCard(clinicData: clinicsData!.last)
                    else
                      const Center(
                        child: Card(
                          color: Color.fromARGB(255, 254, 180, 190),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "لا يوجد لديك حجوزات بعد\n قم بحجز موعد جديد من الزر بمنتصف الشاشة",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    const Text(
                      "حجوزاتي",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
}
