import 'package:clinkcy_local/pages/appointments.dart';
import 'package:clinkcy_local/pages/home.dart';
import 'package:clinkcy_local/home_handler/util/nav_bar.dart';
import 'package:clinkcy_local/home_handler/util/nav_button.dart';
import 'package:clinkcy_local/pages/notifications.dart';
import 'package:clinkcy_local/pages/profile.dart';
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
    return Scaffold(
      body: pages[currentTab],
      floatingActionButton: FloatingActionButton(
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
            text: "Home",
          ),
          NavButton(
            icon: Icons.apartment,
            text: "Appointments",
          ),
          NavButton(
            icon: Icons.notifications,
            text: "Notifications",
          ),
          NavButton(
            icon: Icons.person,
            text: "Profile",
          ),
        ],
      ),
    );
  }
}
