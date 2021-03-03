import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/doctor_record.dart';
import 'package:helloflutter/screens/patient/widgets/doctors_container.dart';
import 'package:http/http.dart' as http;

Future<List<DoctorRecord>> fetchDoctors(String speciality) async {
  print(speciality);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http.get(
    'http://10.0.2.2:3000/speciality/find/$speciality',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: value
    },
  );

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

class DoctorScript extends StatefulWidget {
  final String speciality;
  DoctorScript({this.speciality});

  @override
  _DoctorScriptState createState() => _DoctorScriptState();
}

class _DoctorScriptState extends State<DoctorScript> {
  Future<List<DoctorRecord>> fetchDoctor;
  @override
  void initState() {
    super.initState();
    fetchDoctor = fetchDoctors(widget.speciality);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.36;
    final double itemWidht = size.width / 2;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.no_cell),
          onPressed: () {
            fetchDoctors(widget.speciality);
          },
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          title: Text(widget.speciality),
        ),
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
                          print(snapshot.data[index].user.username);
                          // return Text(snapshot.data[index].user.username);
                          return DoctorContainer(
                            id: snapshot.data[index].user.id,
                            name: snapshot.data[index].user.username,
                            speciality: snapshot.data[index].speciality,
                            about: snapshot.data[index].about,
                            certifications: snapshot.data[index].certificate,
                          );
                        },
                      ));
                  // } else if (!snapshot.hasData) {
                  //   return Text("No doctors found");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            )));
  }
}
