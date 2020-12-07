import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/registration_screen.dart';
import 'package:helloflutter/screens/doctor_details.dart';
import 'package:helloflutter/constants.dart';

/// BUILD A CARD WIDGET TO SHOW ALL THE DOCTORS

class DoctorContainer extends StatelessWidget {
  final int id;
  DoctorContainer({this.id});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorsDetailsScreen(id: id),

          ///GO TO DOCTOR DETAIL SCREEN ON TAP FOR THAT PARTICULAR DOCTOR
          ///WITH THE HELP OF PASSED ID
        ),
      ),
      child: Container(
        margin:  EdgeInsets.all(16.0),
        padding:  EdgeInsets.all(9.0),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 3,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),

        child: Row(
          children: <Widget>[
            SizedBox(
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.network(
                  "${doctorInfo[id].image}",
                  ///pass decoded json data picture
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${doctorInfo[id].name}",

                      ///decoded json data name
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text("${doctorInfo[id].address}",
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      "${doctorInfo[id].speciality}",
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
                ],
              ),
            ),
            SizedBox(width: 9),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorsDetailsScreen(id: id),

                      ///GO TO DOCTOR DETAIL SCREEN ON TAP FOR THAT PARTICULAR DOCTOR
                      ///WITH THE HELP OF PASSED ID
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      "Open",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.green),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xffdbf3e8),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
