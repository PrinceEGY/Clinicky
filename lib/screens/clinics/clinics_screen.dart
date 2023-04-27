import 'package:clinicky/backend/backend_controller.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/screens/clinics/widgets/clinic_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  late Future<List<ClinicData>> futureClinicsData;

  @override
  void initState() {
    super.initState();
    futureClinicsData = BackendController.instance.getDoctorClinics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureClinicsData,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ClinicData> clinicsData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("عياداتي",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              foregroundColor: ColorPallete.mainColor,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                    children: clinicsData
                        .map((value) => ClinicView(clinicData: value))
                        .toList()),
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
