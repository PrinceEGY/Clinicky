import 'dart:convert';
import 'package:clinicky/dummy.dart';

class BackendHandler {
  static final BackendHandler _instance = BackendHandler._internal();
  late int _token = 123;
  factory BackendHandler() {
    return _instance;
  }
  BackendHandler._internal();
  static BackendHandler get instance => _instance;

  int signIn({required email, required password, required type}) {
    var response = jsonDecode(DummyBackend.signIn(
      email: email,
      password: password,
    ));

    _token = response['token'];
    return response["status"];
  }

  int signUp(
      {required name,
      required gender,
      required email,
      required password,
      required type}) {
    var response = jsonDecode(DummyBackend.signUp(
      name: name,
      gender: gender,
      email: email,
      password: password,
      type: type,
    ));
    return response['status'];
  }

  Map<String, dynamic> getUserInfo() {
    Map<String, dynamic> response =
        jsonDecode(DummyBackend.getUserInfo(token: _token));
    return response;
  }
}
