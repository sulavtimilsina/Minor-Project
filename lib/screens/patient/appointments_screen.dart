import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => AppointmentScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "THIS IS THE APPOINTMENT PAGE",
            style: TextStyle(
              fontSize: 50
            ),
          ),
        ),
      ),
    );
  }
}
