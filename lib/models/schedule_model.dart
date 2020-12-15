class Schedule {
  final String id;
  final String doctor;
  final String startTime;
  final String endTime;
  final String date;
  final String patient;

  Schedule(
      {this.id,
      this.doctor,
      this.startTime,
      this.endTime,
      this.date,
      this.patient});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['_id'],
        doctor: json['doctor'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        date: json['date'],
        patient: json['patient']);
  }
}
