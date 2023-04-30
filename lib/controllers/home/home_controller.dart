import 'package:clinicky/util/navbar/nav_bar.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:clinicky/view/appointments/appointments_screen.dart';
import 'package:clinicky/view/appointments/create_appointment/find_speciality_screen.dart';
import 'package:clinicky/view/clinics/clinics_screen.dart';
import 'package:clinicky/view/clinics/craete_clinic/create_clinic_screen.dart';
import 'package:clinicky/view/home/home_doctor.dart';
import 'package:clinicky/view/home/home_patient.dart';
import 'package:clinicky/view/notifications/notifications.dart';
import 'package:clinicky/view/profile/profile_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  late Future<UserData> futureUserData;
  late UserData userData;

  Future<UserData> setUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData(
      name: prefs.getString("userName"),
      type: prefs.getString("userType"),
      gender: prefs.getString("userGender"),
    );
    return userData;
  }

  @override
  void initState() {
    super.initState();
    futureUserData = setUserInfo();
  }

  final List<StatefulWidget> pages = [
    const HomePagePatient(),
    const AppointmentPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];
  var currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureUserData,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          userData = snapshot.data;
          if (userData.type == "doctor") pages[0] = const HomePageDoctor();
          if (userData.type == "doctor") pages[1] = const ClinicsPage();
          return SafeArea(
            child: Scaffold(
              body: pages[currentTab],
              floatingActionButton: FloatingActionButton(
                backgroundColor: ColorPallete.mainColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: userData.type == "doctor"
                          ? const CreateClinicPage()
                          : const SpecialityPickPage(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: NavBar(
                onTabChange: (newIndex) => setState(() {
                  currentTab = newIndex;
                }),
                tabs: [
                  const NavButton(
                    icon: Icons.home,
                    text: "الرئيسية",
                  ),
                  NavButton(
                    icon: userData.type == "doctor"
                        ? Icons.apartment
                        : Icons.calendar_month,
                    text: userData.type == "doctor" ? "العيادات" : "الحجوزات",
                  ),
                  const NavButton(
                    icon: Icons.notifications,
                    text: "الإشعارات",
                  ),
                  const NavButton(
                    icon: Icons.person,
                    text: "الحساب",
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Clinicky",
                    style: TextStyle(
                        color: ColorPallete.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 70,
                        fontFamily: "poppins"),
                  ),
                  SizedBox(height: 20),
                  SpinKitThreeBounce(
                    color: ColorPallete.mainColor,
                    size: 100,
                  ),
                ],
              )),
            ),
          );
        }
      },
    );
  }
}
