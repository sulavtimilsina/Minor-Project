import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/doctor_record.dart';
import 'package:helloflutter/models/speciality.dart';

import 'package:flutter/material.dart';
import 'package:helloflutter/screens/patient/widgets/doctors_container.dart';
import 'package:http/http.dart' as http;

Future<List<DoctorRecord>> fetchDoctors() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http
      .get('http://10.0.2.2:3000/doctorRouter/speciality', headers: <String, String>{
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

class Doctors extends StatefulWidget {
  final Speciality speciality;
  Doctors({Key key, @required this.speciality}) : super(key: key);
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  Future<List<DoctorRecord>> fetchDoctor;

  @override
  void initState() {
    super.initState();
    fetchDoctor = fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
      ),
          body: Container(
        child: FutureBuilder<List<DoctorRecord>>(
          future: fetchDoctor,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data[index].about);
                    return DoctorContainer(
                      username:snapshot.data[index].user.username,
                      speciality:snapshot.data[index].speciality,
                      about: snapshot.data[index].about,
                      certificate: snapshot.data[index].certificate,
                      );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
