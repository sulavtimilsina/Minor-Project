import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:group_radio_button/group_radio_button.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './patient/home_screen.dart';
import './doctor//home_screen.dart';

Future<User> createUser(
    String username, String email, String password, String userType) async {
  final http.Response response = await http.post('http://10.0.2.2:3000/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'userType': userType
      }));
  //print("this is response");
  //print(response.headers['x-auth-token']);
  if (response.statusCode == 200) {
    //print(response.headers['x-auth-token']);

    // final storage = new FlutterSecureStorage();
    // await storage.write(key: "x-auth-token", value: response.headers);
    final user = User.fromJson(jsonDecode(response.body));
    //print(user.id);
    return user;
  } else {
    //print(response.body);
    final message = User.fromJson(jsonDecode(response.body));
    // return message;
    print(message.message);
    throw Exception(message.message);
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _verticalGroupValue = "patient";
  List<String> _status = ["patient", "doctor"];
  Future<User> _futureUser;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue[300],
          Colors.blue[200],
          Colors.blue[100],
        ])),
        child: (_futureUser == null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: _username,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.perm_identity,
                                            color: Colors.white,
                                          ),
                                          hintText: 'Username',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.perm_identity,
                                            color: Colors.white,
                                          ),
                                          hintText: 'Email or Phone number',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: _password,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: Colors.white,
                                          ),
                                          hintText: 'Password',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RadioGroup<String>.builder(
                                      direction: Axis.vertical,
                                      groupValue: _verticalGroupValue,
                                      onChanged: (value) => setState(() {
                                        _verticalGroupValue = value;
                                      }),
                                      items: _status,
                                      itemBuilder: (item) => RadioButtonBuilder(
                                        item,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Container(
                              height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue[400]),
                              child: Center(
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      _futureUser = createUser(
                                          _username.text,
                                          _email.text,
                                          _password.text,
                                          _verticalGroupValue);
                                    });
                                    //print(_futureUser);
                                  },
                                  child: Text(
                                    'Create',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            : FutureBuilder<User>(
                future: _futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.userType);
            if (snapshot.data.userType == 'patient') {
                      Future.delayed(Duration.zero, () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientHome()));
                      });
                    } else {
                      Future.delayed(Duration.zero, () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorHome()));
                               });
                    }
                    //return Text(snapshot.data.username);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}
