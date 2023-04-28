class AppointmentData {
  String? sId;
  String? appointmentDate;
  String? bookingTime;
  AppointmentStatus? status;
  String? doctorName;
  String? clinicName;
  String? specialization;
  String? location;

  AppointmentData({
    this.sId,
    this.appointmentDate,
    this.bookingTime,
    this.status,
    this.doctorName,
    this.clinicName,
    this.specialization,
    this.location,
  });

  AppointmentData.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    appointmentDate = json['appointmentDate'];
    bookingTime = json['bookingTime'];
    status = _getStatus(json['status']);
    doctorName = json['clinick']['doctor']['name'];
    clinicName = json['clinick']['clinicName'];
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
