import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/appointment_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/view/clinics/widgets/appointment_card.dart';
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
  final TextEditingController _searchController = TextEditingController();

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
                title: Text(
                    appointmentsData != null
                        ? appointmentsData.first.clinicName!
                        : "عرض العيادة",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)),
                foregroundColor: ColorPallete.mainColor,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    if (appointmentsData != null)
                      ...appointmentsData.map((value) =>
                          AppointmentClinicCard(appointmentData: value))
                    else
                      const Center(
                        child: Card(
                          color: Color.fromARGB(255, 254, 180, 190),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "لا يوجد لديك حجوزات قادمة\n قم بحجز موعد جديد من الزر بمنتصف الشاشة",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
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
