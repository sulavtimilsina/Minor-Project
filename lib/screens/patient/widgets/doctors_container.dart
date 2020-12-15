import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:helloflutter/screens/patient/appointmentlist.dart';

import 'package:helloflutter/screens/patient/doctor_details.dart';

/// BUILD A CARD WIDGET TO SHOW ALL THE DOCTORS
class DoctorContainer extends StatelessWidget {
  final String id;
  final String name;
  final String speciality;
  final String about;
  final String certifications;

  // final String experience;
  // final String address;
  // final String image;
  // final String workingHours;
  // final String nmcNumber;
  // final String education;

  DoctorContainer({
    this.id,
    this.name,
    this.about,
    this.certifications,
    this.speciality,
    // this.experience,
    // this.address,
    // this.image,

    // this.workingHours,
    // this.nmcNumber,
    // this.education
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorsDetailsScreen(
            id: id,
            name: name,
            about: about,
            speciality: speciality,
            certifications: certifications,
          ),

          ///GO TO DOCTOR DETAIL SCREEN ON TAP FOR THAT PARTICULAR DOCTOR
          ///WITH THE HELP OF PASSED ID
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        //padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                    "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",

                    ///pass decoded json data picture
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Dr. $name",

                  ///decoded json data name
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 23)),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                padding: const EdgeInsets.all(9.0),
                child: Text(
                  speciality,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.black54),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  color: Color(0X6EEED37A),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorsDetailsScreen(
                        id: id,
                        name: name,
                        about: about,
                        speciality: speciality,
                        certifications: certifications,
                      ),

                      ///GO TO DOCTOR DETAIL SCREEN ON TAP FOR THAT PARTICULAR DOCTOR
                      ///WITH THE HELP OF PASSED ID
                    ),
                  ),
                  child: Container(
                      width: 63,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(Icons.person_outline)),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentList(
                                id: id,
                              ))),
                  child: Container(
                    width: 63,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(Icons.calendar_today_outlined),
                  ),
                ),
                Container(
                  width: 63,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(Icons.chat_bubble_outline_rounded),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
