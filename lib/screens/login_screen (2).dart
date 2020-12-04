import 'package:flutter/material.dart';
import 'file:///D:/flutterdevlopment/flutter_ui/lib/screens/registration_screen.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
            padding:EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/register.jpg'),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.left,
                  onChanged: (value){
                    //DO SOMETHING WHEN THE VALE IS CHANGED IN TEXT FIELD
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: "Phone Number*"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  textAlign: TextAlign.left,
                  obscureText: true,
                  onChanged: (value){
                    //DO SOMETHING WHEN THE VALE IS CHANGED IN TEXT FIELD
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: "Password*"),
                ),
                Center(
                  child: RoundedButton(
                    onPressed: (){},
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
            ),
        ),
      ),
    );
  }
}
