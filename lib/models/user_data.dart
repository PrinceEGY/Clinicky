class UserData {
  String? sId;
  String? name;
  String? password;
  String? email;
  String? gender;
  String? type;

  UserData(
      {this.sId, this.name, this.password, this.email, this.gender, this.type});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      sId: json['id'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      gender: json['gender'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['gender'] = gender;
    data['type'] = type;
    return data;
  }
}

class DoctorData extends UserData {
  String? specialization;

  DoctorData({
    super.sId,
    super.name,
    super.password,
    super.email,
    super.gender,
    super.type,
    this.specialization,
  });
  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
        sId: json['id'],
        name: json['name'],
        password: json['password'],
        email: json['email'],
        gender: json['gender'],
        type: json['type'],
        specialization: json['specialization']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['gender'] = gender;
    data['type'] = type;
    data['specialization'] = specialization;
    return data;
  }
}
