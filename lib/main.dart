import 'package:flutter/material.dart';
import './screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: (context, child) => MediaQuery(
      //   data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      //   child: child,
      // ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
