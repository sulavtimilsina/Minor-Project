import 'package:flutter/material.dart';
import 'package:helloflutter/screens/registration_screen.dart';
import 'screens/patient/shop_screen.dart';
import 'screens/login_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen(), debugShowCheckedModeBanner: false);
  }
}
