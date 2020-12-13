import 'package:flutter/material.dart';


import 'package:flutter/cupertino.dart';

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
          certifications: certifications,),

          ///GO TO DOCTOR DETAIL SCREEN ON TAP FOR THAT PARTICULAR DOCTOR
          ///WITH THE HELP OF PASSED ID
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
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
                  "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",

                  ///pass decoded json data picture
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,

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
                      Text("address",
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                  Container(
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








// class DoctorContainer extends StatelessWidget {
//   final String username;
//   final String speciality;
//   final String certificate;
//   final String about;

//   DoctorContainer({
//     this.username,
//     this.speciality,
//     this.certificate,
//     this.about,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => DoctorDetail(
//                       username: username,
//                       speciality: speciality,
//                       about: about,
//                       certificate: certificate,
//                     )));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 15.0),
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               username,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: Text(
//                 speciality,
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: Colors.black54,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             )
//           ],
//         ),
//         decoration: BoxDecoration(
//             color: Color(0xFF6488E4),
//             borderRadius: BorderRadius.circular(30.0)),
//       ),
//     );
//   }
// }
