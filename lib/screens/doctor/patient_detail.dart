import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/user_model.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser(String userId) async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http.get(
      'http://10.0.2.2:3000/users/userDetail/$userId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: value
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void addPatient(String userId) async {
  print(userId);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http.post('http://10.0.2.2:3000/doctorsPatient',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: value
      },
      body: jsonEncode(<String, String>{
        'patientId': userId,
      }));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('user added');
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print('not added');
  }
}

class PatientDetail extends StatefulWidget {
  final String patientId;
  PatientDetail({this.patientId});

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  Future<User> user;
  @override
  void initState() {
    super.initState();
    user = fetchUser(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        actions: [
          InkWell(
            onTap: () {
              addPatient(widget.patientId);
              Navigator.pop(context);
            },
            child: Center(
                child: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(color: Colors.pink),
                    child: Text('Add Patient'))),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.username);
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
