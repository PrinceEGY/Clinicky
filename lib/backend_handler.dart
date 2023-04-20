import 'dart:convert';
import 'package:clinicky/dummy.dart';

class BackendHandler {
  static final BackendHandler _instance = BackendHandler._internal();
  late String token;
  factory BackendHandler() {
    return _instance;
  }
  BackendHandler._internal();
  static BackendHandler get instance => _instance;

  int signIn({email, password, type}) {
    var response =
        jsonDecode(DummyData.signIn(email: email, password: password));
    return response["status"];
  }
}
