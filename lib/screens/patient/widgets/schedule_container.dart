import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<int> bookSchedule(String scheduleId) async {
  print(scheduleId);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final http.Response response =
      await http.post('http://10.0.2.2:3000/schedule/appointment',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: value
          },
          body: jsonEncode(<String, String>{
            'scheduleId': scheduleId,
          }));
  return response.statusCode;
}

class Schedules extends StatefulWidget {
  final String id;
  final String doctor;
  final String startTime;
  final String endTime;
  final String date;
  final String patient;

  Schedules(
      {this.id,
      this.doctor,
      this.startTime,
      this.endTime,
      this.date,
      this.patient});

  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  Future<int> _bookSchedule;
  @override
  Widget build(BuildContext context) {
    print("this is patient");
    print(widget.patient);
    if (_bookSchedule == null) {
      return InkWell(
        onTap: () {
          if (widget.patient == null) {
            setState(() {
              _bookSchedule = bookSchedule(widget.id);
            });
          } else {
            print("already booked");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: (widget.patient != null) ? Colors.red : Colors.blue,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                widget.startTime + " -  " + widget.endTime,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
      );
    } else {
      return FutureBuilder<int>(
        future: _bookSchedule,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("booked");
          } else {
            print('no data');
          }
          return CircularProgressIndicator();
        },
      );
    }
  }
}
