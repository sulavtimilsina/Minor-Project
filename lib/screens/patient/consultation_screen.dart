import 'package:flutter/material.dart';

class ConstultaionScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ConstultaionScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: Icon(Icons.sort),
        title: Text('Constultaion'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
