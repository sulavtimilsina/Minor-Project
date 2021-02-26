import 'package:helloflutter/models/user_model.dart';

class DoctorPatient {
  final User doctor;
  final User patient;

  DoctorPatient(
      {this.doctor,this.patient});

  factory DoctorPatient.fromJson(Map<String, dynamic> json) {
    return DoctorPatient(
      doctor: User.fromJson(json['doctor']),
        patient: User.fromJson(json['patient']));
  }
}
