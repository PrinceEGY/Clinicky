import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/view/appointments/widgets/speciality_card_view.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class SpecialityPickPage extends StatefulWidget {
  const SpecialityPickPage({super.key});

  @override
  State<SpecialityPickPage> createState() => _SpecialityPickPageState();
}

class _SpecialityPickPageState extends State<SpecialityPickPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("إنشاء موعد جديد",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          foregroundColor: ColorPallete.mainColor,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(30),
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
                const Text(
                  "التخصص",
                  style: TextStyle(
                      fontSize: 24,
                      color: ColorPallete.mainColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                IntrinsicWidth(
                  child: Wrap(
                    runSpacing: 30,
                    alignment: WrapAlignment.spaceAround,
                    children: ClinicData.specialities
                        .map((value) => SpecialityVIew(
                            size: 130,
                            specialization: value,
                            iconPath:
                                "assets/images/speciality_icons/clinic.png"))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
