import 'package:helloflutter/models/user_model.dart';

class Task {
  final String id;
  final String startTime;
  final String endTime;
  final String date;
  final User patient;

  Task({this.startTime, this.endTime, this.date, this.patient, this.id});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['_id'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        date: json['date'],
        patient: json['patient'] == null
            ? json['patient']
            : User.fromJson(json['patient']));
  }
}
