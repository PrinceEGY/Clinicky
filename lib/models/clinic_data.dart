import 'package:flutter/material.dart';

class ClinicData {
  static List<String> specialities = [
    "جلدية",
    "أسنان",
    "نفسية",
    "اطفال وحديثي الولادة",
    "مخ وأعصاب",
    "عظام",
    "نساء وتوليد",
    "انف واذن وحنجرة",
    "قلب وأوعية دموية",
    "باطنة",
    "جراحة",
    "عيون",
    "مسالك بولية",
    "طب اسرة",
    "تجميل",
  ];

  String? sId;
  String? clinicName;
  String? phone;
  String? location;
  String? specialization;
  String? price;
  String? about;
  List<String>? availableDays;
  List<TimeOfDay?>? availableTimeSlots;
  int? rating = 0;

  ClinicData(
      {this.sId,
      this.clinicName,
      this.phone,
      this.location,
      this.specialization,
      this.price,
      this.about,
      this.availableDays,
      this.availableTimeSlots,
      this.rating});

  ClinicData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clinicName = json['clinicName'];
    phone = json['phone'];
    location = json['location'];
    specialization = json['specialization'];
    price = json['price'];
    about = json['about'];
    availableDays = json['openDates']['days'];
    availableTimeSlots = json["openDates"]['time'].map((value) {
      var time = value.split(":");
      TimeOfDay(hour: time[0], minute: time[1]);
    });
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
              "${value!.hour}:${value.minute.toString().padLeft(2, "0")}")
          .toList()
    };
    data['rating'] = rating.toString();
    return data;
  }
}
