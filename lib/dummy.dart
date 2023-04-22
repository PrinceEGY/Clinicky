import 'dart:convert';

class DummyBackend {
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

  static String signUp({name, gender, email, password, type}) {
    if (email == "ahmed@gmail.com") {
      return json.encode({
        "status": 401,
      });
    } else {
      return json.encode({"status": 200});
    }
  }

  static String getUserInfo({token}) {
    if (token == 123) {
      return json.encode({
        "status": 200,
        "name": "Ahmed Mohsen",
        "email": "ahmed25004@hotmail.com",
        "gender": "Male",
        "type": "patient",
      });
    } else {
      return json.encode({"status": 400});
    }
  }
}
