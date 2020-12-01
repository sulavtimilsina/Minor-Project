import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => AppointmentScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Appointment'));
  }
}
