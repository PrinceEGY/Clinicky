class UserData {
  final String name;
  final String email;
  final String gender;
  final String type;

  UserData(
      {required this.name,
      required this.email,
      required this.gender,
      required this.type});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['type'] = type;
    return data;
  }
}
