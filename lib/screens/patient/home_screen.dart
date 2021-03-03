import 'package:helloflutter/screens/patient/shop_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helloflutter/models/doctor_record.dart';
import 'package:helloflutter/models/speciality.dart';
import 'package:helloflutter/screens/doctor/widgets/drawer.dart';
import 'package:helloflutter/screens/patient/doctor_category.dart';
import 'package:helloflutter/screens/patient/doctor_details.dart';
import 'package:helloflutter/screens/patient/doctors_screen.dart';

/// THIS PAGE DISPLAYS ALL THE AVAILABLE DOCTORS THAT ARE IN OUR DATABASE
class AppointmentScreen extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<AppointmentScreen> {
  List<Speciality> specialities;
  Future<List<DoctorRecord>> fetchDoctor;

  @override
  void initState() {
    super.initState();
    fetchDoctor = fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {
          fetchDoctors();
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.blueAccent,
            title: Text("Home"),
          ),
          SliverToBoxAdapter(
            child: Container(
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
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Hello, ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(color: Colors.grey),
                                ),
                                // FutureBuilder(
                                //   future: widget.user,
                                //   builder:(BuildContext context , AsyncSnapshot snapshot){

                                //     if(snapshot.hasData){
                                //       return    Text(
                                //         snapshot.data.username.toString().toUpperCase(),
                                //         style: TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.black,
                                //           fontSize: 35,
                                //         ),
                                //       );
                                //     }else {
                                //       return  Container(
                                //         child: Center(
                                //           child: Text("ADD LOADING INDICATOR HERE."),
                                //         ),
                                //       );

                                //     }
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What Do you need?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              HomeCard(
                                title: "Upload Prescription",
                                icon: FontAwesomeIcons.upload,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              HomeCard(
                                title: "Buy Medicine",
                                icon: FontAwesomeIcons.shoppingCart,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopScreen())),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              HomeCard(
                                title: "Record Upload",
                                icon: FontAwesomeIcons.cloudUploadAlt,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              HomeCard(
                                title: "Call Ambulance",
                                icon: FontAwesomeIcons.ambulance,
                                onTap: () =>
                                    UrlLauncher.launch("tel://+9779846903868"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              HomeCard(
                                title: "Request Blood",
                                icon: FontAwesomeIcons.hospital,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              HomeCard(
                                title: "Record Upload",
                                icon: FontAwesomeIcons.cloudUploadAlt,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      CategoriesCard(specialities: specialities),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Doctors",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              FlatButton(
                                child: Text(
                                  "See All",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: ()  {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Doctors();
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 9.0),
                            height: 160,
                            child: FutureBuilder<List<DoctorRecord>>(
                              future: fetchDoctor,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                      3,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return DoctorsDetailsScreen(
                                                  id: snapshot
                                                      .data[index].user.id,
                                                  name: snapshot.data[index]
                                                      .user.username,
                                                  speciality: snapshot
                                                      .data[index].speciality,
                                                  about: snapshot
                                                      .data[index].about,
                                                  certifications: snapshot
                                                      .data[index].certificate,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9.0),
                                          padding: const EdgeInsets.all(9.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.2),
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9.0),
                                                ),
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "assets/images/img1.png"),
                                                  radius: 30.0,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Dr. " +
                                                    "${snapshot.data[index].user.username}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data[index].speciality}",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                "put working hours here",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text("${snapshot.error}"));
                                }

                                // By default, show a loading spinner.
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final List<Speciality> specialities;
  CategoriesCard({@required this.specialities});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Categories",
              style: Theme.of(context).textTheme.headline6,
            ),
            FlatButton(
              child: Text(
                "See All",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DoctorCategory();
                    },
                  ),
                );
              },
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 9.0),
          height: 71,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              specialities.length,
              (index) => Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2),
                margin: const EdgeInsets.symmetric(horizontal: 9.0),
                padding: const EdgeInsets.all(9.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.2),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: specialities[index].backgroundColor,
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: Icon(
                        FontAwesomeIcons.heart,
                        size: 35,
                        color: Colors.white,
                      ),
                      // child: Image.asset("${specialities[index].imgAssetPath}"),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text("${specialities[index].speciality}"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  HomeCard({this.title, this.icon, this.onTap});

  /// make parameters required
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        ///Push to different screens
        child: Container(
          height: MediaQuery.of(context).size.height / 7,
          padding: const EdgeInsets.all(11.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue.withOpacity(.3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 30,
                color: Colors.red.withOpacity(.5),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
