import 'package:clinicky/backend_handler.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final request = BackendHandler.instance;
  late UserData userData;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() {
    var response = request.getUserInfo();
    userData = UserData.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPallete.mainColor,
          title: const Text("Home"),
        ),
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(userData.name, style: const TextStyle(fontSize: 40)),
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(userData.gender == "Male"
                    ? "assets/images/male.png"
                    : "assets/images/female.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
