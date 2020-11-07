import 'package:flutter/material.dart';
import 'package:helloflutter/screens/doctor/information_screen.dart';

class DoctorHome extends StatefulWidget {
    static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => DoctorHome(),
      );

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text("My Health"),
        actions: [IconButton(icon: Icon(Icons.add_a_photo), onPressed: null)],
      ),
      body: Column(
        children: [
          Text('You are a doctor'),
          SizedBox(height: 10),
          FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Info()),
                );
              },
              child: Text("Add Data"))
        ],
      ),
    );
  }
}
