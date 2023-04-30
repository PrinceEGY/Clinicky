class NotificationData {
  String? sId;
  String? clinicName;
  String? doctorName;
  String? specialization;
  String? appointmentDate;
  String? bookingTime;
  String? type;
  NotificationData({
    this.sId,
    this.clinicName,
    this.doctorName,
    this.specialization,
    this.appointmentDate,
    this.bookingTime,
    this.type,
  });

  // Map<String,dynamic>toJson(){
  //   final Map<String,dynamic>data = <String,dynamic>{};
  //   data['id'] = sId;
  //   data['clinicName'] = clinicName;
  //   data['docto']

  //   return data;
  // }
  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    clinicName = json['clinicName'];
    doctorName = json['doctorName'];
    specialization = json['specialization'];
    appointmentDate = json['appointmentDate'];
    bookingTime = json['bookingTime'];
    type = json['typeOfNotification'];
  }
}
