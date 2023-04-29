import 'package:clinicky/controllers/backend/backend_controller.dart';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:clinicky/util/widgets/error_popup.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateClinicPage extends StatefulWidget {
  const CreateClinicPage({super.key});

  @override
  State<CreateClinicPage> createState() => _CreateClinicPageState();
}

class Exception {
  final String message;
  Exception(this.message);

  @override
  String toString() {
    return message;
  }
}

class _CreateClinicPageState extends State<CreateClinicPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _location = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();

  List<String> availableDays = [];
  List<TimeOfDay?> availableTimeSlots = [];
  String? _specialization;
  var _infoIsValid = false;

  Future<TimeOfDay?> addTimeSlot() async {
    late final TimeOfDay? time;
    try {
      time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (availableTimeSlots.contains(time)) {
        throw Exception("الموعد مضاف بالفعل");
      }
    } catch (err) {
      showDialogMessage(
        context: context,
        color: ColorPallete.red,
        text: err.toString(),
      );
      return null;
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("انشاء عيادة جديدة",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          foregroundColor: ColorPallete.mainColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //! Name Field
                    TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "اسم العيادة",
                          prefixIcon: const Icon(Icons.apartment),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            _infoIsValid = false;
                            return "الرجاء قم بادخال اسم صحيح";
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    //! phone Field
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      controller: _phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "رقم التلفون",
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      validator: (value) => checkPhone(value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //! Location Field
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      controller: _location,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "عنوان العيادة",
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          _infoIsValid = false;
                          return "الرجاء قم بادخال عنوان صحيح";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //! Price Field
                    TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false),
                        textInputAction: TextInputAction.next,
                        controller: _price,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "سعر الكشف",
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.startsWith("-")) {
                            _infoIsValid = false;
                            return "الرجاء قم بادخال رقم صحيح";
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      isExpanded: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _infoIsValid = false;
                          return "الرجاء قم باختيار التخصص";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "التخصص",
                        prefixIcon: const Icon(Icons.person),
                      ),
                      items: ClinicData.specialities
                          .map<DropdownMenuItem<String>>((String value) =>
                              DropdownMenuItem<String>(
                                  value: value, child: Text(value)))
                          .toList(),
                      onChanged: (value) => _specialization = value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //! Description Field
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      controller: _description,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "وصف العيادة",
                        prefixIcon: const Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          _infoIsValid = false;
                          return "الرجاء قم بادخال وصف للعيادة";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 40,
                color: ColorPallete.mainColor,
              ),
              const Text(
                "ايه الأيام اللي العيادة هتكون متاحة فيها؟",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              CustomCheckBoxGroup(
                wrapAlignment: WrapAlignment.center,
                enableButtonWrap: true,
                buttonValuesList: const [
                  "Saturday",
                  "Sunday",
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday"
                ],
                buttonLables: const [
                  "السبت",
                  "الأحد",
                  "الإثنين",
                  "الثلاثاء",
                  "الأربعاء",
                  "الخميس",
                  "الجمعة"
                ],
                checkBoxButtonValues: (values) {
                  availableDays = values;
                },
                selectedColor: ColorPallete.mainColor,
                unSelectedColor: Colors.white,
              ),
              const Divider(
                height: 40,
                color: ColorPallete.mainColor,
              ),
              const Text(
                "ايه المواعيد اللي العيادة هتكون متاحة فيها؟",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  var time = await addTimeSlot();
                  setState(() {
                    if (time != null) availableTimeSlots.add(time);
                  });
                },
                child: const Text("اضافة موعد جديد"),
              ),
              CustomRadioButton(
                wrapAlignment: WrapAlignment.center,
                elevation: 0,
                enableButtonWrap: true,
                buttonValues: availableTimeSlots,
                buttonLables: availableTimeSlots
                    .map((value) =>
                        "${value!.hour.toString().padLeft(2, "0")}:${value.minute.toString().padLeft(2, "0")} \u274C")
                    .toList(),
                radioButtonValue: (value) {
                  availableTimeSlots.remove(value);
                },
                buttonTextStyle: const ButtonTextStyle(
                  textStyle: TextStyle(fontFamily: "roboto"),
                ),
                selectedColor: Colors.white,
                unSelectedColor: Colors.white,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),
              onPressed: () {
                _infoIsValid = true;
                FocusScope.of(context).unfocus();
                _formKey.currentState!.validate();
                if (_infoIsValid) {
                  _validateInput();
                }
              },
              child: const Text(
                "اضافة العيادة",
                style: TextStyle(fontSize: 18),
              )),
        ),
      ),
    );
  }

  String? checkPhone(value) {
    if (value == null || value.isEmpty) {
      _infoIsValid = false;
      return "الرجاء ادخل رقم العيادة";
    } else if (!RegExp(
            r"^([\+]|00)?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")
        .hasMatch(value)) {
      _infoIsValid = false;
      return "الرجاء ادخال رقم صالح";
    }
    return null;
  }

  _validateInput() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const SpinKitSquareCircle(
        color: Colors.white,
        size: 100,
      ),
    );
    try {
      if (availableDays.isEmpty) {
        throw Exception("الرجاء اختيار يوم واحد على الاقل");
      } else if (availableTimeSlots.isEmpty) {
        throw Exception("الرجاء اضافه موعد واحد على الاقل");
      }
      var clinicData = ClinicData(
        clinicName: _name.text,
        phone: _phone.text,
        specialization: _specialization,
        location: _location.text,
        price: _price.text,
        about: _description.text,
        availableDays: availableDays,
        availableTimeSlots: availableTimeSlots,
        rating: 0,
      );

      await BackendController.instance.addNewClinic(clinicData: clinicData);
      if (!mounted) return;
      showDialogMessage(
          context: context,
          text: "تم اضافة العيادة بنجاح",
          color: ColorPallete.green);
      Navigator.pop(context);
    } catch (err) {
      showDialogMessage(
        context: context,
        text: err.toString(),
        color: ColorPallete.red,
      );
    }
    if (!mounted) return;
    Navigator.pop(context);
  }
}
