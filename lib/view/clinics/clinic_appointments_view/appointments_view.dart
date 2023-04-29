import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ClinicAppointmentViewPage extends StatefulWidget {
  final String clinicID;
  const ClinicAppointmentViewPage({
    super.key,
    required this.clinicID,
  });

  @override
  State<ClinicAppointmentViewPage> createState() =>
      _ClinicAppointmentViewPageState();
}

class _ClinicAppointmentViewPageState extends State<ClinicAppointmentViewPage> {
  late Future<List<AppointmentData>?> futureClinicData;
  @override
  void initState() {
    super.initState();
    futureClinicData = BackendController.instance
        .getAllAppointmentsByClinicId(clinicId: widget.clinicID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: futureClinicData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<AppointmentData>? appointmentsData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text("الحجوزات",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                foregroundColor: ColorPallete.mainColor,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
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
      ),
    );
  }
}
