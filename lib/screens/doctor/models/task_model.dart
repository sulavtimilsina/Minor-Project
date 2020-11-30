class Task {
  final String startTime;
  final String endTime;
  final String date;

  Task({this.startTime, this.endTime, this.date});

  factory Task.fromJson(dynamic json) {
    return Task(
        startTime: json['startTime'],
        endTime: json['endTime'],
        date: json['date']);
  }
}
