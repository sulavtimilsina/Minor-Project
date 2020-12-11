import 'package:flutter/material.dart';
import 'package:helloflutter/components/rounded_button.dart';
import 'package:helloflutter/screens/register_screen.dart';
import '../constants.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/screens/doctor/tabs.dart';
import 'dart:convert';
//import './register_screen.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import './patient/patient_tabs.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool isLoggedin = false; ///???????????????????????????????????

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: (_futureUser == null) ?
            ListView(
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    child: Image.asset('assets/images/health-insurance.png',
                    height: 200,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: _email,
                  validator: (value){
                    if(value.isEmpty) return "Cannot be empty";
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  decoration: kTextFieldDecoration.copyWith(hintText: "Email*"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textAlign: TextAlign.left,
                  obscureText: true,
                  controller: _password,
                  validator: (value){
                    if(value.isEmpty) return "Cannot be empty";
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: "Password*"),
                ),
                Center(
                  child: RoundedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _futureUser = createUser(
                            _email.text,
                            _password.text,
                          );
                          //if (isLoggedin == true) {}
                        });
                      }
                    },
                    colour: Colors.green,
                    title: "Sign In",
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      /// IMPLLEMENTATION OF FORGOT PASSWORD
                    },

                    child: Text(
                      "Forgot Password"
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return RegistrationScreen();
                      },),);
                      /// IMPLLEMENTATION OF FORGOT PASSWORD
                    },
                    child: Text(
                        "Sign up instead"
                    ),
                  ),
                ),
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
      ),
    );
  }
}