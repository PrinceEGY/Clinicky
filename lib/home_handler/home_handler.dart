import 'package:clinicky/backend/backend_controller.dart';
import 'package:clinicky/home_handler/navbar/nav_bar.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:clinicky/screens/appointments/appointments_screen.dart';
import 'package:clinicky/screens/clinics/clinics_screen.dart';
import 'package:clinicky/screens/clinics/craete_clinic/create_clinic_screen.dart';
import 'package:clinicky/screens/home/home.dart';
import 'package:clinicky/screens/notifications/notifications.dart';
import 'package:clinicky/screens/profile/profile_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class HomeHandler extends StatefulWidget {
  const HomeHandler({super.key});

  @override
  State<HomeHandler> createState() => _HomeHandlerState();
}

class _HomeHandlerState extends State<HomeHandler> {
  final request = BackendController.instance;
  late Future<UserData> futureUserData;
  late UserData userData;
  @override
  void initState() {
    super.initState();
    futureUserData = request.getUserInfo();
  }

  final pages = [
    const HomePage(),
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
                        child: const CreateClinicPage(),
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
            return const Center(
                child: SpinKitCubeGrid(
              color: ColorPallete.mainColor,
              size: 100,
            ));
          }
        });
  }
}
