import 'package:flutter/material.dart';
import 'package:helloflutter/screens/patient/doctor_screen.dart';
//import 'package:expandable/expandable.dart';
import 'package:helloflutter/screens/doctors_screen.dart';

class DoctorContainer extends StatelessWidget {
  final String username;
  final String speciality;
  final String certificate;
  final String about;

  DoctorContainer({
    this.username,
    this.speciality,
    this.certificate,
    this.about,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetail(
                      username: username,
                      speciality: speciality,
                      about: about,
                      certificate: certificate,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              username,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                speciality,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xFF6488E4),
            borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }
}
