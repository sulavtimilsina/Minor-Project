import 'package:flutter/material.dart';

class DoctorDetail extends StatelessWidget {
  final String username;
  final String speciality;
  final String certificate;
  final String about;

  DoctorDetail(
      {Key key,
      @required this.username,
      this.speciality,
      this.certificate,
      this.about})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print("This is about");
    // print(about);
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(
              "http://lavinephotography.com.au/wp-content/uploads/2017/01/PROFILE-Photography-112.jpg",
              width: MediaQuery.of(context).size.width,
            ),

            Positioned(
              bottom: 0.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10.0),
                      child: Text(
                        username,
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
                      child: Text(
                        speciality,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
                      child: Text(
                        "About",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8.0),
                      child: Text(
                        about,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //   Image.network("http://10.0.2.2:3000/images/5cea93d1-783b-4f49-a992-6c7e6c0769767864868177985972746.jpg")
          ],
        ),
      ),
    );
  }
}
