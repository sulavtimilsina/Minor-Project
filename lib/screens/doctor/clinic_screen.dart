import 'package:flutter/material.dart';

class ClinicPage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ClinicPage(),
      );

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<ClinicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clinic"),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [
                       Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white38),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [Icon(Icons.search), Text("Search")],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text("No click added"),
          ],
        ),
      ),
    );
  }
}
