import 'package:flutter/cupertino.dart';
import 'file:///D:/flutterdevlopment/flutter_ui/lib/components/doctor_container.dart';
import 'package:flutter_ui/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../components/catagories_container.dart';
import 'package:flutter_ui/models/doctor_model.dart';


/// THIS PAGE DISPLAYS ALL THE AVAILABLE DOCTORS THAT ARE IN OUR DATABASE

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  ///USE THIS FUNCTION AFTER IMPLEMENTATION OF DATABASE
  // Future<List<DoctorInfo>> _getDoctorInfo() async {
  //   var data = await http.get("http://www.json-generator.com/api/json/get/cfzShUwMfC?indent=2");
  //   var jsonData = json.decode(data.body);
  //   List<DoctorInfo> doctors = [];
  //   for (var d in jsonData) {
  //     DoctorInfo doctor = DoctorInfo(d["name"], d["email"], d["phone"], d["speciality"], d["address"], d["picture"]);
  //     doctors.add(doctor);
  //   }
  //   print(doctors.length);// REMOVE THIS LATER
  //   return doctors;
  // }
  /// ADD THIS TO BUILDER AFTER DATABASE IMPLEMENTATION
  /// FutureBuilder(
  //           /// future: _getDoctorInfo(),
  //           builder:(BuildContext context , AsyncSnapshot snapshot){
  //
  //             if(snapshot.hasData){
  //              return    ListView.builder(
  //                itemCount: snapshot.data.length,
  //                itemBuilder: (BuildContext context, int index) {
  //                  return DoctorContainer(id: index);
  //                },
  //              );
  //             }else {
  //               return  Container(
  //                 child: Center(
  //                   child: Text("ADD LODING INDICATOR HERE."),
  //                 ),
  //               );
  //
  //             }
  //           },
  //         ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) => Categories(),
        ),
      ),
    );
  }
}

/// DEFINSE THE DOCTOR CLASS FOR STORING DOCTOR INFO MOVE TO ANOTHER FILE


///GO TO A SPECIFIC PAGE  for A SPECIFIC DOCTOR
///FOR TESTINNG CREATE A SPECIFIC PAGE LATER
/// NO LONGER NEEDED CAN DELETE
///
class DoctorDetailPage extends StatelessWidget {
  final DoctorInfo doctor;
  DoctorDetailPage(this.doctor);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
      ),
      body: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              doctor.speciality,
            )
          ],
        ),
      ),
    );
  }
}
