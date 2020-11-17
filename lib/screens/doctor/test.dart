import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'theme/colors/light_colors.dart';
import 'widgets/top_container.dart';
import 'widgets/back_button.dart';
import 'package:http/http.dart' as http;

Future<String> createSchedule(
    String startTime, String endTime, String date) async {
  print(startTime);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final http.Response response = await http.post(
      'http://10.0.2.2:3000/schedule',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: value
      },
      body: jsonEncode(<String, String>{
        'startTime': startTime,
        'endTime': endTime,
        'date': date
      }));
  if (response.statusCode == 200) {
    final message = jsonDecode(response.body);
    print(message);
    return message;
  } else {
    final message = jsonDecode(response.body);
    print(message);
    throw Exception(message);
  }
}

class CreateNewTaskPage extends StatefulWidget {
  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  final TextEditingController _startTime = TextEditingController();

  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _date = TextEditingController();

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _date.text = DateFormat.yMd().format(selectedDate);
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _startTime.text = _time;
      });
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _endTime.text = _time;
      });
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create new task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.bottomRight,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              //textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _startTime,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: Colors.white,
                                ),
                                labelText: 'Start Time',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectEndTime(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.bottomRight,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              //textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _endTime,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: Colors.white,
                                ),
                                labelText: 'End Time',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        //textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _date,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          prefixIcon: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          labelText: 'Date',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print(_startTime);
                      setState(() {
                        createSchedule(
                            _startTime.text, _endTime.text, _date.text);
                        //if (isLoggedin == true) {}
                      });
                    },
                    child: Container(
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: LightColors.kBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
