import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/view/appointments/widgets/appointment_card.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late Future<List<AppointmentData>?> futureAppointmentsData;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureAppointmentsData =
        BackendController.instance.getAllAppointmentsPatient();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureAppointmentsData,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<AppointmentData>? appointmentsData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                "حجوزاتي",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              foregroundColor: ColorPallete.mainColor,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
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
                  const SizedBox(height: 20),
                  if (snapshot.hasData)
                    ...appointmentsData!.reversed
                        .map((value) => AppointmentCard(appointmentData: value))
                        .toList()
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
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                ]),
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
