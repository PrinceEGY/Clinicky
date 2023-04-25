import 'package:clinicky/home_handler/navbar/nav_bar.dart';
import 'package:clinicky/screens/appointments/appointments_screen.dart';
import 'package:clinicky/screens/home/home.dart';
import 'package:clinicky/screens/notifications/notifications.dart';
import 'package:clinicky/screens/profile/profile_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class HomeHandler extends StatefulWidget {
  const HomeHandler({super.key});

  @override
  State<HomeHandler> createState() => _HomeHandlerState();
}

class _HomeHandlerState extends State<HomeHandler> {
  final pages = [
    const HomePage(),
    const AppointmentPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];
  var currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[currentTab],
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorPallete.mainColor,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBar(
          onTabChange: (newIndex) => setState(() {
            currentTab = newIndex;
          }),
          tabs: const [
            NavButton(
              icon: Icons.home,
              text: "الرئيسية",
            ),
            NavButton(
              icon: Icons.apartment,
              text: "الحجوزات",
            ),
            NavButton(
              icon: Icons.notifications,
              text: "الإشعارات",
            ),
            NavButton(
              icon: Icons.person,
              text: "الحساب",
            ),
          ],
        ),
      ),
    );
  }
}
