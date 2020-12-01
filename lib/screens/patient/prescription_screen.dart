import 'package:flutter/material.dart';

class PrescriptionScreen extends StatelessWidget {
    static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => PrescriptionScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('PrescriptionScreen')
    );
  }
}