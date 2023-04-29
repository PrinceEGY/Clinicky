import 'dart:convert';
import 'package:http/http.dart';

class DummyBackend {
  static Response signIn({required request}) {
    var jsonObject = jsonDecode(request);
    late Response res;

    if (jsonObject['email'] == "ahmed@gmail.com" &&
        jsonObject['password'] == "123456") {
      res =
          Response(json.encode({"message": "signed in successfully..."}), 200);
    } else {
      res = Response(json.encode({"message": "Wrong credential"}), 401);
    }
    return res;
  }

  static Response signUp({required request}) {
    var jsonObject = jsonDecode(request);
    late Response res;
    if (jsonObject["email"] == "ahmed@gmail.com") {
      res = Response(json.encode({"message": "Registered succefully!"}), 200);
    } else {
      res = Response(json.encode({"message": "Already registered"}), 401);
    }
    return res;
  }

  static Response getUserInfo({required request}) {
    var jsonObject = jsonDecode(request);
    late Response res;
    if (jsonObject['token'] == "123") {
      res = Response(
        json.encode(
          {
            "patient": {
              "name": "Ahmed Mohsen",
              "email": "ahmed25004@hotmail.com",
              "gender": "Male",
              "type": "patient",
            }
          },
        ),
        200,
      );
    } else {
      res = Response(
        json.encode(
          {
            "message": "bad request",
          },
        ),
        400,
      );
    }
    return res;
  }
}
