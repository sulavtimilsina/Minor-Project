import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/components/doctor_container.dart';

import 'package:helloflutter/models/doctor_model.dart';
import 'package:helloflutter/screens/login_screen.dart';
import 'package:helloflutter/screens/patient/mydata.dart';

/// THIS PAGE DISPLAYS ALL THE AVAILABLE DOCTORS THAT ARE IN OUR DATABASE
class AppointmentScreen extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<AppointmentScreen> {
  List<DoctorInfo> doctorInfo = [
    DoctorInfo(
      image:
          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",
      about:
          "Jon gradually becomes a pawn of the U.S. government, which gives him the code name Doctor Manhattan—a reference to the Manhattan Project—and a costume which he begrudgingly accepts. Doctor Manhattan chooses as his emblem a representation of a hydrogen atom, whose simplicity he declares to be something that kindles his respect; accordingly, he painlessly burns the mark into his forehead. This preference for material mechanisms marks the beginning of his declining humanity, which is progressively mirrored by his gradual shedding of the uniform; by the end of the 1970s, he refuses to wear anything at all except during mandatory public appearances. ",
      certifications: "5",
      experience: "50",
      address: "Mars",
      name: "Dr Manhattan",
      speciality: "Everything",
      workingHours: "Sun - Fri 09:00 - 05:00",
      nmcNumber: "1013232",
      education: [
        "Bachelors from IOM Nepal",
        "Currently working at Bir Hospital Nepal"
      ],
    ),
    DoctorInfo(
      image:
          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",
      about:
          "Jon gradually becomes a pawn of the U.S. government, which gives him the code name Doctor Manhattan—a reference to the Manhattan Project—and a costume which he begrudgingly accepts. Doctor Manhattan chooses as his emblem a representation of a hydrogen atom, whose simplicity he declares to be something that kindles his respect; accordingly, he painlessly burns the mark into his forehead. This preference for material mechanisms marks the beginning of his declining humanity, which is progressively mirrored by his gradual shedding of the uniform; by the end of the 1970s, he refuses to wear anything at all except during mandatory public appearances. ",
      certifications: "5",
      experience: "50",
      address: "Mars",
      name: "Dr Manhattan",
      speciality: "Everything",
      workingHours: "Sun - Fri 09:00 - 05:00",
      nmcNumber: "1013232",
      education: [
        "Bachelors from IOM Nepal",
        "Currently working at Bir Hospital Nepal"
      ],
    ),
    DoctorInfo(
      image:
          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",
      about:
          "Jon gradually becomes a pawn of the U.S. government, which gives him the code name Doctor Manhattan—a reference to the Manhattan Project—and a costume which he begrudgingly accepts. Doctor Manhattan chooses as his emblem a representation of a hydrogen atom, whose simplicity he declares to be something that kindles his respect; accordingly, he painlessly burns the mark into his forehead. This preference for material mechanisms marks the beginning of his declining humanity, which is progressively mirrored by his gradual shedding of the uniform; by the end of the 1970s, he refuses to wear anything at all except during mandatory public appearances. ",
      certifications: "5",
      experience: "50",
      address: "Mars",
      name: "Dr Manhattan",
      speciality: "Everything",
      workingHours: "Sun - Fri 09:00 - 05:00",
      nmcNumber: "1013232",
      education: [
        "Bachelors from IOM Nepal",
        "Currently working at Bir Hospital Nepal"
      ],
    ),
    DoctorInfo(
      image:
          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",
      about:
          "Jon gradually becomes a pawn of the U.S. government, which gives him the code name Doctor Manhattan—a reference to the Manhattan Project—and a costume which he begrudgingly accepts. Doctor Manhattan chooses as his emblem a representation of a hydrogen atom, whose simplicity he declares to be something that kindles his respect; accordingly, he painlessly burns the mark into his forehead. This preference for material mechanisms marks the beginning of his declining humanity, which is progressively mirrored by his gradual shedding of the uniform; by the end of the 1970s, he refuses to wear anything at all except during mandatory public appearances. ",
      certifications: "5",
      experience: "50",
      address: "Mars",
      name: "Dr Manhattan",
      speciality: "Everything",
      workingHours: "Sun - Fri 09:00 - 05:00",
      nmcNumber: "1013232",
      education: [
        "Bachelors from IOM Nepal",
        "Currently working at Bir Hospital Nepal"
      ],
    ),
    DoctorInfo(
      image:
          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",
      about:
          "Jon gradually becomes a pawn of the U.S. government, which gives him the code name Doctor Manhattan—a reference to the Manhattan Project—and a costume which he begrudgingly accepts. Doctor Manhattan chooses as his emblem a representation of a hydrogen atom, whose simplicity he declares to be something that kindles his respect; accordingly, he painlessly burns the mark into his forehead. This preference for material mechanisms marks the beginning of his declining humanity, which is progressively mirrored by his gradual shedding of the uniform; by the end of the 1970s, he refuses to wear anything at all except during mandatory public appearances. ",
      certifications: "5",
      experience: "50",
      address: "Mars",
      name: "Dr Manhattan",
      speciality: "Everything",
      workingHours: "Sun - Fri 09:00 - 05:00",
      nmcNumber: "1013232",
      education: [
        "Bachelors from IOM Nepal",
        "Currently working at Bir Hospital Nepal"
      ],
    ),
    DoctorInfo(
      image:
          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",
      about:
          "Jon gradually becomes a pawn of the U.S. government, which gives him the code name Doctor Manhattan—a reference to the Manhattan Project—and a costume which he begrudgingly accepts. Doctor Manhattan chooses as his emblem a representation of a hydrogen atom, whose simplicity he declares to be something that kindles his respect; accordingly, he painlessly burns the mark into his forehead. This preference for material mechanisms marks the beginning of his declining humanity, which is progressively mirrored by his gradual shedding of the uniform; by the end of the 1970s, he refuses to wear anything at all except during mandatory public appearances. ",
      certifications: "5",
      experience: "50",
      address: "Mars",
      name: "Dr Manhattan",
      speciality: "Everything",
      workingHours: "Sun - Fri 09:00 - 05:00",
      nmcNumber: "1013232",
      education: [
        "Bachelors from IOM Nepal",
        "Currently working at Bir Hospital Nepal"
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text("Doctors"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Roshan Chaudhary'),
              accountEmail: Text('roshan@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE"),
              ),
            ),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('Feedback'),
              trailing: Icon(Icons.feedback),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyData()));
              },
              child: ListTile(
                title: Text('My data'),
                trailing: Icon(Icons.book_online),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: () async {
                final storage = new FlutterSecureStorage();
                await storage.delete(key: "x-auth-token");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
            Container(
              height: MediaQuery.of(context).size.height * 0.74,
              child: ListView.builder(
                itemCount: doctorInfo.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => DoctorContainer(
                  //id: doctorInfo[index].id,
                  image: doctorInfo[index].image,
                  certifications: doctorInfo[index].certifications,
                  about: doctorInfo[index].about,
                  experience: doctorInfo[index].experience,
                  name: doctorInfo[index].name,
                  speciality: doctorInfo[index].speciality,
                  nmcNumber: doctorInfo[index].nmcNumber,
                  address: doctorInfo[index].address,
                ),
              ),
            ),
          ],
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
