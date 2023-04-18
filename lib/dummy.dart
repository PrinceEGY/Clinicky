import 'dart:convert';

class DummyData {
  static String signIn({email, password}) {
    if (email == "ahmed@gmail.com" && password == "123456") {
      return json.encode({
        "status": 200,
        "token": 123,
      });
    } else {
      return json.encode({
        "status": 401,
        "token": null,
      });
    }
  }
}
