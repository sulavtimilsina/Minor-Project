
import 'package:flutter/material.dart';
import 'package:flutter_ui/constants.dart';
import 'package:flutter_ui/components/rounded_button.dart';

class DoctorsDetailsScreen extends StatefulWidget {
  final int id;
  DoctorsDetailsScreen({@required this.id});
  @override
  _DoctorsDetailsScreenState createState() => _DoctorsDetailsScreenState();
}

class _DoctorsDetailsScreenState extends State<DoctorsDetailsScreen> {
  bool _showAbout = false;

  ///CONTROLS THE SEE MORE PART OF THE ABOUT SECTION
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, _) => Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: MediaQuery.of(context).size.height / 3,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(doctorInfo[widget.id].image),/// BANEKO WIDGET KO ID

                      ///IMAGE OF THE DOCTOR
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15.0),
                    ),

                    ///THIS IS THE BACK BUTTON
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DraggableScrollableSheet(
                  ///BOTTOM CARD FOR INFORMATION ABOUT DOCTOR
                  initialChildSize: 2/3,
                  minChildSize: 2/3,
                  maxChildSize: 1,
                  builder: (context, scrollController) => Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          offset: Offset(0, -3),
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${doctorInfo[widget.id].name}",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "${doctorInfo[widget.id].address}",
                                        style:
                                        Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Text(
                                        "${doctorInfo[widget.id].speciality}",
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
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.messenger,
                                  color: Colors.white,
                                ),
                                onPressed: () {},

                                ///IMPLEMENT WHAT HAPPENS WHEN YOU CLICK THE MESSAGE IVCON
                              ),
                            ),
                            SizedBox(width: 15),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Text(
                          "About",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10,),
                        Wrap(
                          /// This is for showing all info about doctor
                          children: <Widget>[
                            Text(
                              "${doctorInfo[widget.id].about}",
                              maxLines: _showAbout ? null : 1,

                              ///if true show all lines if not show one line
                            ),
                            FlatButton(
                              child: Text(
                                _showAbout ? "See Less" : "See More",

                                ///CHANGES VICE VERSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: Colors.blue),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showAbout = !_showAbout;

                                  ///changes the value of show more
                                });
                              },
                            )
                          ],
                        ),
                        Text(
                          "Availability",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Row(
                          children: <Widget>[
                            Text("${doctorInfo[widget.id].workingHours}"),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {},

                              ///OPEN BOOKING  PAGE WHEN THIS IS PRESSED
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
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: Color(0xffdbf3e8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        Text(
                            "Education",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            ListView.builder(
                              itemCount: doctorInfo[widget.id].education.length,
                                shrinkWrap: true,
                                itemBuilder:(BuildContext context ,int index)=>Text(
                                  doctorInfo[widget.id].education[index],
                                ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Stats",

                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                    "${doctorInfo[widget.id].nmcNumber} ",
                                    style:
                                    Theme.of(context).textTheme.headline6),
                                Text(
                                  "NMC Number",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                    "${doctorInfo[widget.id].experience} Years",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                Text(
                                  "Experience",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("${doctorInfo[widget.id].certifications}",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                Text(
                                  "Certifications",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: RoundedButton(
                              onPressed: () {},

                              ///BOOK AN APPOINTMENT ON PRESSED
                              title: "Make An Appointment",
                              colour: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
