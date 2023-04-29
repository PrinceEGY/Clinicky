import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/view/appointments/widgets/clinic_card_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ClinicPickPage extends StatefulWidget {
  final String specialization;
  const ClinicPickPage({
    super.key,
    required this.specialization,
  });

  @override
  State<ClinicPickPage> createState() => _ClinicPickPageState();
}

class _ClinicPickPageState extends State<ClinicPickPage> {
  late Future<List<ClinicData>?> futureClinicsData;
  @override
  void initState() {
    super.initState();
    futureClinicsData = BackendController.instance
        .getSpecializationClinics(specialization: widget.specialization);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: futureClinicsData,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ClinicData>? clinicsData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("عيادات ${widget.specialization}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              foregroundColor: ColorPallete.mainColor,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "العيادات",
                      style: TextStyle(
                          fontSize: 24,
                          color: ColorPallete.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    if (snapshot.hasData)
                      ...clinicsData!
                          .map((value) => ClinicViewPatient(clinicData: value))
                          .toList()
                    else
                      const Center(
                        child: Card(
                          color: Color.fromARGB(255, 254, 180, 190),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "عذراً، لا يوجد عيادات حاليا في هذا التخصص",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
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
    ));
  }
}
