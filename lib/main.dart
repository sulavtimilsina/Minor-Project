import 'package:flutter/material.dart';
import 'package:helloflutter/screens/registration_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegistrationScreen(), debugShowCheckedModeBanner: false);
  }
}
