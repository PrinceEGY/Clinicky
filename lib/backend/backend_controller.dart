import 'dart:convert';
import 'package:clinicky/models/clinic_data.dart';
import 'package:clinicky/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ServerType { local, host }

class BackendController {
  static final BackendController _instance = BackendController._internal();
  factory BackendController() {
    return _instance;
  }
  BackendController._internal();
  static BackendController get instance => _instance;

  static const _serverType = ServerType.host;
  final hostDomain =
      _serverType == ServerType.host ? "https://clinicky-v1.onrender.com" : "";
  String? _token;

  Future<void> signIn(
      {required email,
      required password,
      required type,
      keepSingedIn = true}) async {
    var jsonObject = jsonEncode({
      "email": email,
      "password": password,
      "type": type,
    });

    var route = "/api/user/login";
    var response = await http.post(
      Uri.parse(hostDomain + route),
      headers: {"Content-Type": "application/json"},
      body: jsonObject,
    );
    if (response.statusCode == 200) {
      debugPrint("Singed In successfuly");
      UserData userData = UserData.fromJson(jsonDecode(response.body));
      _token = _getTokenFromResponse(response)!;
      if (keepSingedIn) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userToken", _token!);
        await prefs.setString("userName", userData.name!);
        await prefs.setString("userType", userData.type!);
        await prefs.setString("userGender", userData.gender!);
      }
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> signUp({required UserData userData}) async {
    var route = "/api/user/signup";

    var response = await http.post(
      Uri.parse(hostDomain + route),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData.toJson()),
    );
    if (response.statusCode == 200) {
      debugPrint("Signed up successfully");
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<UserData> getUserInfo() async {
    var route = "/api/profile";
    var response = await http.get(
      Uri.parse(hostDomain + route),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": _token!,
        "Authorization": "Bearer $_token",
      },
    );
    if (response.statusCode == 200) {
      debugPrint("User Data fetched successfully");
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }

    return UserData.fromJson(jsonDecode(response.body));
  }

  Future<void> addNewClinic({required ClinicData clinicData}) async {
    var route = "/api/clinicks";
    var response = await http.post(
      Uri.parse(hostDomain + route),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": _token!,
        "Authorization": "Bearer $_token",
      },
      body: jsonEncode(clinicData.toJson()),
    );
    if (response.statusCode == 200) {
      debugPrint("Clinic added successfully");
    } else {
      print(jsonEncode(clinicData.toJson()));
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<List<ClinicData>?> getDoctorClinics() async {
    var route = "/api/clinicks";

    var response = await http.get(
      Uri.parse(hostDomain + route),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": _token!,
        "Authorization": "Bearer $_token",
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Clinics Data fetched successfully");
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }

    return jsonDecode(response.body)
        .map<ClinicData>((value) => ClinicData.fromJson(value))
        .toList();
  }

  Future<List<ClinicData>?> getSpecializationClinics(
      {required String specialization}) async {
    var route = "/api/search/specialization?specialization=";
    var response = await http.get(
      Uri.parse(hostDomain + route + specialization),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": _token!,
        "Authorization": "Bearer $_token",
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Clinics Data fetched successfully");
      return jsonDecode(response.body)
          .map<ClinicData>((value) => ClinicData.fromJson(value))
          .toList();
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<ClinicData> getClinicDetails({required String clinicId}) async {
    var route = "/api/clinicks/";
    var response = await http.get(
      Uri.parse(hostDomain + route + clinicId),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": _token!,
        "Authorization": "Bearer $_token",
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Clinic Data fetched successfully");
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
    return ClinicData.fromJson(jsonDecode(response.body));
  }

  Future<void> addNewAppointment(
      {required String clinicId, required String date}) async {
    var route = "/api/appointments";
    var jsonObject = jsonEncode({
      "clinick": clinicId,
      "appointmentDate": date,
      "bookingTime": DateTime.now().toString(),
    });

    var response = await http.post(
      Uri.parse(hostDomain + route),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": _token!,
        "Authorization": "Bearer $_token",
      },
      body: jsonObject,
    );
    if (response.statusCode == 200) {
      debugPrint("appointment added successfully");
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  String? _getTokenFromResponse(Response response) {
    var headerList = response.headers['set-cookie']!.split(";");
    for (var kvPair in headerList) {
      var kv = kvPair.split("=");
      if (kv[0] == "x-auth-token") return kv[1];
    }
    return null;
  }

  setToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BackendController.instance._token = prefs.getString("userToken");
  }

  clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userToken");
    prefs.remove("userName");
    prefs.remove("userType");
    prefs.remove("userGender");
  }
}

class Exception {
  final String message;
  Exception(this.message);

  @override
  String toString() {
    return message;
  }
}
