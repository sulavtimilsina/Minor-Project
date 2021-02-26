import 'package:flutter/material.dart';
import 'package:helloflutter/screens/doctor/widgets/drawer.dart';

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
        title: Text('Constultaion'),
      ),
      drawer: DrawerWidget(),
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
