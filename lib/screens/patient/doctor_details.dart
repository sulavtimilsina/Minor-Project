import 'package:flutter/material.dart';
import 'package:helloflutter/components/rounded_button.dart';
import 'package:helloflutter/screens/patient/appointmentlist.dart';
//DoctorsDetailsScreen

class DoctorsDetailsScreen extends StatefulWidget {
  final String id;
  final String name;
  final String speciality;
  final String about;
  final String certifications;
  DoctorsDetailsScreen({
    @required this.id,
    this.name,
    this.about,
    this.certifications,
    this.speciality,
  });
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
                      image: NetworkImage(
                          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE"),

                      /// BANEKO WIDGET KO ID
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
                  initialChildSize: 2 / 3,
                  minChildSize: 2 / 3,
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
                                    widget.name,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "address",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Text(
                                      widget.speciality,
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
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          /// This is for showing all info about doctor
                          children: <Widget>[
                            Text(
                              widget.about,
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
                            Text("workingHours"),
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
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // ListView.builder(
                            //   itemCount: doctorInfo[widget.id].education.length,
                            //     shrinkWrap: true,
                            //     itemBuilder:(BuildContext context ,int index)=>Text(
                            //       doctorInfo[widget.id].education[index],
                            //     ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                                Text(".nmcNumber",
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
                                Text("experience Years",
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
                                Text("certifications",
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentList(id: widget.id,)));
                              },

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
