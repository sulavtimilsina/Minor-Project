import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/data_model.dart';
import 'package:helloflutter/screens/doctor/widgets/drawer.dart';
import 'package:http/http.dart' as http;

Future<List<Data>> getDatas() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http
      .get('http://10.0.2.2:3000/prescription', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: value
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var tagObjsJson = jsonDecode(response.body) as List;
    List<Data> tagObjs =
        tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();

    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class PrescriptionScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => PrescriptionScreen(),
      );

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  Future<List<Data>> prescriptions;
  @override
  void initState() {
    super.initState();
    prescriptions = getDatas();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidht = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          title: Text('All Prescription'),
        ),
        drawer: DrawerWidget(),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: FutureBuilder<List<Data>>(
            future: prescriptions,
            builder: (context, snapshot) {
              return GridView.count(
                  childAspectRatio: itemHeight / itemWidht,
                  crossAxisCount: 2,
                  children: List.generate(
                    snapshot.data.length,
                    (index) {
                      //print(snapshot.data[index].imageUrl);
                      return Container(
                          //height: MediaQuery.of(context).size.height * 0.1,
                          margin: EdgeInsets.all(10.0),
                          color: Colors.amber,
                          child: Image.network(
                            snapshot.data[index].imageUrl,
                            //'http://10.0.2.2:3000/images/${snapshot.data[index].imageUrl}',
                            fit: BoxFit.fill,
                          ));
                    },
                  ));
            },
          ),
        ));
  }
}
