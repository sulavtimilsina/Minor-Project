import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/screens/doctor/create_new_task_page.dart';
import 'package:helloflutter/screens/doctor/models/task_model.dart';
import 'package:helloflutter/screens/doctor/patient_detail.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Future<List<Task>> fetchSchedule() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response =
      await http.get('http://10.0.2.2:3000/schedule', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: value
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var tagObjsJson = jsonDecode(response.body) as List;
    List<Task> tagObjs =
        tagObjsJson.map((tagJson) => Task.fromJson(tagJson)).toList();
    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void deleteSchedule(String scheduleId) async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  await http.delete('http://10.0.2.2:3000/schedule/remove/delete/$scheduleId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: value
      });
}

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  Future<List<Task>> schedule;
  Future<int> response;

  String _subjectText,
      _startTimeText,
      _endTimeText,
      _dateText,
      _timeDetails,
      _meetingId,
      _patientId;
  @override
  void initState() {
    super.initState();
    schedule = fetchSchedule();
    _subjectText = '';
    _startTimeText = '';
    _endTimeText = '';
    _dateText = '';
    _timeDetails = '';
    _meetingId = '';
    _patientId = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calender"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewTaskPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: FutureBuilder<List<Task>>(
          future: schedule,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SfCalendar(
                //view: CalendarView.week,
                dataSource: MeetingDataSource(
                    _getDataSource(snapshot.data, snapshot.data.length)),
                todayHighlightColor: Colors.red,
                onTap: calendarTapped,
              );
            } else {
              return Text("${snapshot.error}");
            }
          },
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Meeting appointmentDetails = details.appointments[0];
      _patientId = appointmentDetails.userId;
      _meetingId = appointmentDetails.meetingId;
      _subjectText = appointmentDetails.eventName;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.from)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.from).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.to).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
      print(_meetingId);
    } else if (details.targetElement == CalendarElement.calendarCell) {
      _subjectText = "You have tapped cell";
      _dateText = DateFormat('MMMM dd, yyyy').format(details.date).toString();
      _timeDetails = '';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: new Text('$_subjectText')),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientDetail(
                                    patientId: _patientId,
                                  )));
                    },
                    child: Text(_patientId == null ? '' : 'Details'))
              ],
            ),
            content: Container(
              height: 80,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$_dateText',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(_timeDetails,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                  onTap: () {
                    deleteSchedule(_meetingId);
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.delete)),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Close'))
            ],
          );
        });
  }
}

//List<Task> schedule, int n
List<Meeting> _getDataSource(List<Task> schedule, int n) {
  List<Meeting> meetings = <Meeting>[];
  for (int i = 0; i < n; i++) {
    //print(schedule[i].date.split('/')[0]);
    //print(int.parse(schedule[i].startTime[0]));
    final DateTime startTime = DateTime(
        int.parse(schedule[i].date.split('/')[2]),
        int.parse(schedule[i].date.split('/')[0]),
        int.parse(schedule[i].date.split('/')[1]),
        int.parse(schedule[i].startTime.split(':')[0]),
        int.parse(schedule[i].startTime.split(':')[1]),
        0);
    //print(startTime);
    final DateTime endTime = DateTime(
        int.parse(schedule[i].date.split('/')[2]),
        int.parse(schedule[i].date.split('/')[0]),
        int.parse(schedule[i].date.split('/')[1]),
        int.parse(schedule[i].endTime.split(':')[0]),
        int.parse(schedule[i].endTime.split(':')[1]),
        0);
    final String subject = schedule[i].patient == null
        ? "Not Booked"
        : schedule[i].patient.username;
    final String userId =
        schedule[i].patient == null ? null : schedule[i].patient.id;
    final String meetingId = schedule[i].id;
    print(subject);
    meetings.add(Meeting(subject, startTime, endTime, const Color(0xFF0F8644),
        false, userId, meetingId));
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> meetings) {
    appointments = meetings;
  }
  @override
  @override
  String getLocation(int index) {
    return appointments[index].meetingId;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  String getNotes(int index) {
    return appointments[index].userId;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.userId, this.meetingId);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String userId;
  String meetingId;
}
