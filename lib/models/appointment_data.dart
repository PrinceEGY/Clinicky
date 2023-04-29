class AppointmentData {
  String? sId;
  String? appointmentDate;
  String? bookingTime;
  String? patientName;
  AppointmentStatus? status;
  String? price;
  String? doctorName;
  String? doctorId;
  String? clinicName;
  String? clinicId;
  String? specialization;
  String? location;

  AppointmentData({
    this.sId,
    this.appointmentDate,
    this.bookingTime,
    this.status,
    this.price,
    this.patientName,
    this.doctorName,
    this.doctorId,
    this.clinicName,
    this.clinicId,
    this.specialization,
    this.location,
  });

  AppointmentData.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    appointmentDate = json['appointmentDate'];
    bookingTime = json['bookingTime'];
    status = _getStatus(json['status']);
    patientName = json['patient']?['name'];
    price = json['clinick']?['price'];
    doctorName = json['clinick']['doctor']['name'];
    doctorId = json['clinick']['doctor']['id'];
    clinicName = json['clinick']['clinicName'];
    clinicId = json['clinick']['id'];
    specialization = json['clinick']['specialization'];
    location = json['clinick']['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = sId;
    data['appointmentDate'] = appointmentDate;
    data['bookingTime'] = bookingTime;
    data['status'] = status;
    data['specialization'] = specialization;
    data['location'] = location;
    data['clinicName'] = clinicName;
    return data;
  }

  AppointmentStatus _getStatus(String status) {
    status = status.toLowerCase();
    if (status == "passed") {
      return AppointmentStatus.passed;
    } else if (status == "completed") {
      return AppointmentStatus.completed;
    } else {
      if (status == "canceled") {
        return AppointmentStatus.canceled;
      } else {
        return AppointmentStatus.pending;
      }
    }
  }
}

enum AppointmentStatus { passed, pending, completed, canceled }
