import 'package:flutter/material.dart';
import 'package:helloflutter/screens/doctor/schedule_screen.dart';
import 'package:helloflutter/screens/registration_screen.dart';
import 'screens/patient/shop_screen.dart';
import 'screens/login_screen.dart';
import 'screens/doctors_screen.dart';
import 'screens/patient/home_screen.dart';
import 'screens/patient/patient_tabs.dart';
import 'screens/patient/doctors_screen.dart';
import 'screens/doctor/doctor_info_add.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DoctorInfoAdd(), debugShowCheckedModeBanner: false);
  }
}
