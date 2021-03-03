import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/doctorPatient.dart';
import 'package:helloflutter/screens/doctor/widgets/drawer.dart';
import 'package:helloflutter/screens/doctor/widgets/user_container.dart';
import 'theme/colors/light_colors.dart';
import 'package:http/http.dart' as http;

Future<List<DoctorPatient>> fetchPatient() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http
      .get('http://10.0.2.2:3000/doctorsPatient', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: value
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var tagObjsJson = jsonDecode(response.body) as List;
    List<DoctorPatient> tagObjs =
        tagObjsJson.map((tagJson) => DoctorPatient.fromJson(tagJson)).toList();

    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<DoctorPatient>> fetchPatients;

  @override
  void initState() {
    super.initState();
    fetchPatients = fetchPatient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      appBar: AppBar(
        title: Text("My Patients"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      drawer: DrawerWidget(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
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
              height: MediaQuery.of(context).size.height * 0.74,
              child: FutureBuilder<List<DoctorPatient>>(
                future: fetchPatients,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data[index].patient.username);
                          return UserContainer(
                            id: snapshot.data[index].patient.id,
                            name: snapshot.data[index].patient.username,
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
