import 'package:flutter/material.dart';

class ClinicData {
  static List<String> specialities = [
    "جلدية",
    "أسنان",
    "نفسية",
    "اطفال",
    "مخ وأعصاب",
    "عظام",
    "نساء وتوليد",
    "انف واذن وحنجرة",
    "قلب ",
    "باطنة",
    "جراحة",
    "عيون",
    "مسالك بولية",
    "طب اسرة",
    "تجميل",
  ];

  String? sId;
  String? clinicName;
  String? doctorName;
  String? phone;
  String? location;
  String? specialization;
  String? price;
  String? about;
  List? availableDays;
  List<TimeOfDay?>? availableTimeSlots;
  List? reservedDates;
  int? rating = 0;

  ClinicData({
    this.sId,
    this.clinicName,
    this.doctorName,
    this.phone,
    this.location,
    this.specialization,
    this.price,
    this.about,
    this.availableDays,
    this.availableTimeSlots,
    this.rating,
  });

  ClinicData.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    clinicName = json['clinicName'];
    doctorName = json['doctor']?['name'];
    phone = json['phone'];
    location = json['location'];
    specialization = json['specialization'];
    price = json['price'];
    about = json['about'];
    availableDays = json['openDates']['days'].cast<String>();
    availableTimeSlots = json["openDates"]['time'].map<TimeOfDay>((value) {
      var time = value.split(":");
      return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]));
    }).toList();
    reservedDates = json['reservedDates'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinicName'] = clinicName;
    data['phone'] = phone;
    data['location'] = location;
    data['specialization'] = specialization;
    data['price'] = price;
    data['about'] = about;
    data['openDates'] = {
      "days": availableDays,
      "time": availableTimeSlots!
          .map((value) =>
              "${value!.hour.toString().padLeft(2, "0")}:${value.minute.toString().padLeft(2, "0")}")
          .toList()
    };
    return data;
  }

  bool isSlotAvailable(DateTime day, TimeOfDay timeSlot) {
    String currentDate =
        "${day.year}-${day.month.toString().padLeft(2, "0")}-${day.day.toString().padLeft(2, "0")}";
    for (var item in reservedDates!) {
      if (item['day'] == currentDate) {
        var itemIndex = availableTimeSlots!.indexOf(timeSlot);
        return itemIndex == -1 ? false : !item['time'][itemIndex];
      }
    }
    return false;
  }
}
