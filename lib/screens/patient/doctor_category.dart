import 'package:helloflutter/screens/doctor/widgets/drawer.dart';

import '../../models/speciality.dart';
import '../../data/data.dart';
import 'doctors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

class DoctorCategory extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => DoctorCategory(),
      );
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DoctorCategory> {
  List<Speciality> specialities;

  @override
  void initState() {
    super.initState();

    specialities = getSpeciality();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors"),
      ),
      drawer: DrawerWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find Your \nConsultant",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                height: 590,
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(specialities.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Doctors()),
                        );
                      },
                      child: Specialist(
                        imgAssetPath: specialities[index].imgAssetPath,
                        speciality: specialities[index].speciality,
                        noOfDoctors: specialities[index].noOfDoctors,
                        backgroundColor: specialities[index].backgroundColor,
                      ),
                    );
                  }),
                ))
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Specialist extends StatelessWidget {
  String imgAssetPath;
  String speciality;
  int noOfDoctors;
  Color backgroundColor;
  Specialist(
      {this.imgAssetPath,
      this.speciality,
      this.noOfDoctors,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(24)),
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            speciality,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Image.asset(
            imgAssetPath,
            height: 100,
            fit: BoxFit.scaleDown,
          )
        ],
      ),
    );
  }
}
