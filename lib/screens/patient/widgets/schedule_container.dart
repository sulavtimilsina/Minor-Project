import 'package:flutter/material.dart';

class Schedules extends StatelessWidget {
  final String id;
  final String doctor;
  final String startTime;
  final String endTime;
  final String date;

  Schedules({this.id, this.doctor, this.startTime, this.endTime, this.date});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue
          
        ),
        child: Text(startTime +" "+ endTime),
      ),
    );
  }
}