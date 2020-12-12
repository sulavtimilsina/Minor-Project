import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:helloflutter/constants.dart';
import 'package:helloflutter/models/speciality.dart';
import 'package:helloflutter/data/data.dart';
import 'package:helloflutter/screens/doctor_details.dart';
import 'package:helloflutter/screens/doctors_screen.dart';
import 'patient_tabs.dart';
import 'package:helloflutter/models/user_model.dart';


class PatientHome extends StatefulWidget {
  final Future<User> user;
  PatientHome({   this.user});

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  List<Speciality> specialities;



    @override
  void initState()  {
    super.initState();
    specialities =getSpeciality();

    }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 2,
            floating: true,
            backgroundColor: MyColors.white,
            leading: Icon(
              Icons.menu_outlined,
              color: Colors.black,
            ),
            // actions: <Widget>[
            //   GestureDetector(
            //     onTap: () {},
            //
            //     /// DO SOMETHING HERE
            //     child: Icon(Icons.notifications,
            //       color: Colors.black,
            //     ),
            //   ),
            //   SizedBox(
            //     width: 15.0,
            //   ),
            //   GestureDetector(
            //     onTap: () {},
            //
            //     ///GO TO SHOPPING PAGE
            //     child: Icon(Icons.shopping_cart,
            //       color: Colors.black,
            //     ),
            //   ),
            // ],
            title: Text("Home"),
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
                                FutureBuilder(
                                      future: widget.user,
                                      builder:(BuildContext context , AsyncSnapshot snapshot){

                                if(snapshot.hasData){
                                return    Text(
                                   snapshot.data.username.toString().toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 35,
                                  ),
                                );
                                }else {
                                return  Container(
                                child: Center(
                                child: Text("ADD LOADING INDICATOR HERE."),
                                ),
                                );

                                }
                                },
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            fillColor: MyColors.grey,
                            filled: true,
                            prefixIcon: Icon(Icons.search_sharp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      CarouselSlider.builder(
                        itemCount: carouselImages.length,
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 6,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.easeInCubic,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder: (BuildContext context, int itemIndex) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.blue.withOpacity(.3),
                          ),
                          child: carouselImages[itemIndex],
                            width: double.infinity,

                        ),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("What Do you need?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: <Widget>[
                              HomeCard(title: "Upload Prescription",icon: FontAwesomeIcons.upload,),
                             SizedBox(width: 10,),
                             HomeCard(title: "Buy Medicine", icon: FontAwesomeIcons.shoppingCart,onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientTabsPage(2))),),
                              SizedBox(width: 10,),
                              HomeCard(title: "Record Upload",icon: FontAwesomeIcons.cloudUploadAlt,)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              HomeCard(title: "Call Ambulance",icon: FontAwesomeIcons.ambulance,onTap: ()=> UrlLauncher.launch("tel://+9779846903868"),),
                              SizedBox(width: 10,),
                              HomeCard(title: "Request Blood", icon: FontAwesomeIcons.hospital,),
                              SizedBox(width: 10,),
                              HomeCard(title: "Record Upload",icon: FontAwesomeIcons.cloudUploadAlt,)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      CategoriesCard(specialities: specialities),
                      SizedBox(height: 10.0,),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Doctors",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              FlatButton(
                                child: Text("See All",
                                  style: TextStyle(
                                      color: MyColors.blue
                                  ),
                                ),
                                onPressed: ()  {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DoctorPage();
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
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                              5,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return DoctorsDetailsScreen(id: index);
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                  constraints: BoxConstraints(
                                        minWidth: MediaQuery.of(context).size.width / 3,

                                  ),

                                  margin: const EdgeInsets.symmetric(horizontal: 9.0),
                                  padding: const EdgeInsets.all(9.0),
                                  decoration: BoxDecoration(
                                      color: MyColors.blue.withOpacity(.2),
                                      border: Border.all(color: MyColors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(9.0),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage("assets/images/img1.png"),
                                            radius: 30.0,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text("${doctorInfo[index].name}",style: TextStyle(
                                          fontWeight:FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black54,
                                        ),),
                                        Text("${doctorInfo[index].speciality}",
                                        style:TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                        ),
                                        SizedBox(height: 7,),
                                        Text("${doctorInfo[index].workingHours}",
                                          style:TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                  ),
                                ),
                                    ),
                              ),
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
            Text("Categories",
              style: Theme.of(context).textTheme.headline6,
            ),
            FlatButton(
              child: Text("See All",
                style: TextStyle(
                    color: MyColors.blue
                ),
              ),
              onPressed: () {},
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
                  color: MyColors.blue.withOpacity(.2),
                  border: Border.all(color: MyColors.grey),
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
                      child: FaIcon(FontAwesomeIcons.heart,
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
 HomeCard({this.title , this.icon ,this.onTap}); /// make parameters required
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,///Push to different screens
        child: Container(
          height: MediaQuery.of(context).size.height / 7,
          padding: const EdgeInsets.all(11.0),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(10.0),
            color: MyColors.blue.withOpacity(.3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FaIcon(
                icon,
                size: 30,
                color: MyColors.red.withOpacity(.5),
              ),
              Text(
                title,
                textAlign:TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
