import 'package:clinicky/backend/backend_controller.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:clinicky/screens/auth/login_screen.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final request = BackendController.instance;
  late Future<UserData> futureUserData;

  @override
  void initState() {
    super.initState();
    futureUserData = request.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: futureUserData,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          UserData userData = snapshot.data;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text("حسابي",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                foregroundColor: ColorPallete.mainColor,
              ),
              body: SizedBox(
                width: screenWidth,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(userData.gender == "ذكر"
                            ? "assets/images/male.png"
                            : "assets/images/female.png"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        userData.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          request.clearUserData();
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const LoginScreen(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.logout,
                              color: ColorPallete.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "تسجيل الخروج",
                              style: TextStyle(
                                  color: ColorPallete.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
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
