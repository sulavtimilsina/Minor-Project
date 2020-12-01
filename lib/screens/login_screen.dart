import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/screens/doctor/tabs.dart';
import 'dart:convert';
import './register_screen.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import './patient/patient_tabs.dart';
//import 'doctor/tabs.dart';

Future<User> createUser(String email, String password) async {
  final http.Response response = await http.post(
      'http://10.0.2.2:3000/users/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }));
  //print("this is response");
  //print(response.headers['x-auth-token']);
  if (response.statusCode == 200) {
    print(response.headers['x-auth-token']);

    final storage = new FlutterSecureStorage();
    await storage.write(
        key: "x-auth-token", value: response.headers['x-auth-token']);
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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Future<User> _futureUser;
  bool isLoggedin = false;
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                            'assets/images/health-insurance.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(60))),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: <Widget>[
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
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Forget Password",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white),
                              child: Center(
                                child: FlatButton(
                                  splashColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _futureUser = createUser(
                                        _email.text,
                                        _password.text,
                                      );
                                      //if (isLoggedin == true) {}
                                    });
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
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
                                  splashColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(
                                        color: Colors.black,
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
                    if (snapshot.data.userType == 'patient') {
                      Future.delayed(Duration.zero, () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientTabsPage()));
                      });
                    } else {
                      Future.delayed(Duration.zero, () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabsPage()));
                      });
                    }
                    return Text(snapshot.data.username);
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
