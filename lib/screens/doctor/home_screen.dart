import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/doctor_record.dart';
import 'package:helloflutter/screens/doctor/widgets/drawer.dart';
import 'package:helloflutter/screens/login_screen.dart';
import 'package:http/http.dart' as http;

Future<List<DoctorRecord>> fetchDoctors() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http.get('http://10.0.2.2:3000/doctorRouter/myData',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: value
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var tagObjsJson = jsonDecode(response.body) as List;
    List<DoctorRecord> tagObjs =
        tagObjsJson.map((tagJson) => DoctorRecord.fromJson(tagJson)).toList();

    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class DoctorHome extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => DoctorHome(),
      );

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  Future<List<DoctorRecord>> fetchDoctor;

  @override
  void initState() {
    super.initState();
    fetchDoctor = fetchDoctors();
  }

  logout() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "x-auth-token");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.36;
    final double itemWidht = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          title: Text("My Health"),
          actions: [IconButton(icon: Icon(Icons.add_a_photo), onPressed: null)],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.nat_outlined),
          onPressed: () {
            fetchDoctors();
          },
        ),
        drawer: DrawerWidget(),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.82,
          child: FutureBuilder<List<DoctorRecord>>(
            future: fetchDoctor,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                    childAspectRatio: itemHeight / itemWidht,
                    crossAxisCount: 2,
                    children: List.generate(
                      snapshot.data.length,
                      (index) {
                        return Text(snapshot.data[index].about);
                      },
                    ));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
