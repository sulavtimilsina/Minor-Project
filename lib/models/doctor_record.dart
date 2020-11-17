import 'package:helloflutter/models/user_model.dart';

class DoctorRecord {
  final String id;
  final String certificate;
  final String speciality;
  final String about;
  final User user;

  DoctorRecord({
    this.id,
    this.certificate,
    this.speciality,
    this.about,
    this.user
  });

  factory DoctorRecord.fromJson(Map<String, dynamic> json) {
    return DoctorRecord(  
        id: json['_id'],
        certificate: json['certificate'],
        about: json['about'],
        speciality: json['speciality'],
        user: User.fromJson(json['user']));
  }
}
