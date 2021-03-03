import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/doctor_record.dart';
import 'package:flutter/material.dart';
import 'package:helloflutter/screens/patient/widgets/doctors_container.dart';
import 'package:http/http.dart' as http;

Future<List<DoctorRecord>> fetchDoctors() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http.get(
      'http://10.0.2.2:3000/doctorRouter/speciality',
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

class Doctors extends StatefulWidget {
  //final Speciality speciality;
  //Doctors({Key key, @required this.speciality}) : super(key: key);
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.36;
    final double itemWidht = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text("Doctors"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white38),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [Icon(Icons.search), Text("Search")],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
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
                          return DoctorContainer(
                            id: snapshot.data[index].user.id,
                            name: snapshot.data[index].user.username,
                            speciality: snapshot.data[index].speciality,
                            about: snapshot.data[index].about,
                            certifications: snapshot.data[index].certificate,
                          );
                        },
                      ));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
