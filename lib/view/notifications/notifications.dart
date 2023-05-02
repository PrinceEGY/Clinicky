import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/notification_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/view/notifications/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<NotificationData>?> futureNotificationsData;

  @override
  void initState() {
    super.initState();
    futureNotificationsData =
        BackendController.instance.getAllNotificationsByPatient();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureNotificationsData,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<NotificationData> notificationsData = snapshot.data;
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text("إشعاراتي",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  foregroundColor: ColorPallete.mainColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: notificationsData.reversed
                        .map((value) =>
                            NotificationCard(notificationData: value))
                        .toList(),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Card(
                color: Color.fromARGB(255, 254, 180, 190),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "لا يوجد لديك إشعارات",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          }
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
