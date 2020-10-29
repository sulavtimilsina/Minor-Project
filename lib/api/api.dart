import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://10.0.2.2:3000";

class API {
  static Future getUsers() {
    var url = baseUrl + "/users";
    return http.get(url);
  }
}