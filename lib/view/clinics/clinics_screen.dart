import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/view/clinics/widgets/clinic_card.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ClinicsPage extends StatefulWidget {
  const ClinicsPage({super.key});

  @override
  State<ClinicsPage> createState() => _ClinicsPageState();
}

class _ClinicsPageState extends State<ClinicsPage> {
  late Future<List<ClinicData>?> futureClinicsData;
  final TextEditingController _searchController = TextEditingController();

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
          List<ClinicData>? clinicsData = snapshot.data;
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
                    ...clinicsData!
                        .map((value) => ClinicCard(clinicData: value))
                        .toList()
                  else
                    const Center(
                      child: Card(
                        color: Color.fromARGB(255, 254, 180, 190),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "لا يوجد لديك عيادات متاحة، الرجاء قم باضافة عيادة واحدة على الأقل",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
