import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/schedule_model.dart';
import 'package:helloflutter/screens/patient/widgets/schedule_container.dart';
import 'package:http/http.dart' as http;

Future<List<Schedule>> fetchSchedules(String doctorId) async {
  print(doctorId);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http.get(
    'http://10.0.2.2:3000/schedule/appointment/$doctorId',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: value
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var tagObjsJson = jsonDecode(response.body) as List;
    List<Schedule> tagObjs =
        tagObjsJson.map((tagJson) => Schedule.fromJson(tagJson)).toList();

    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class AppointmentList extends StatefulWidget {
  final String id;
  AppointmentList({this.id});

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  Future<List<Schedule>> fetchSchedule;
  @override
  void initState() {
    super.initState();
    fetchSchedule = fetchSchedules(widget.id);
  }

  @override
  Widget build(BuildContext context) {
      var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1;
    final double itemWidht = size.width / 2;
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text('Select Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<List<Schedule>>(
            future: fetchSchedule,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: itemHeight / itemWidht,
                  children: List.generate(snapshot.data.length, (index) {
                    print(snapshot.data[index].date);
                    return Schedules(
                      id: snapshot.data[index].id,
                      startTime:snapshot.data[index].startTime,
                      endTime:snapshot.data[index].startTime,
                      date:snapshot.data[index].date,
                      patient:snapshot.data[index].patient
                    );
                  },
                  )
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
