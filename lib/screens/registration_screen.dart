import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'package:group_button/group_button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool checkedStatus = false;
  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose(); //Dispose controller when widget removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Container(
                height: 100.0,
                child: Image.asset('images/register.jpg'),
              ),
              SizedBox(
                height: 45.0,
              ),
              Center(
                child: GroupButton(
                  isRadio: true,
                  spacing: 20,
                  onSelected: (index, isSelected) => print('$index button is selected'),
                  buttons: ["Patient" ,"Doctor"],
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  //DO SOMETHING WHEN THE VALE IS CHANGED IN TEXT FIELD
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Phone Number*"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: true,
                controller: dateController,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  //DO SOMETHING WHEN THE VALE IS CHANGED IN TEXT FIELD
                },
                onTap: () async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  dateController.text = date.toString().substring(0, 10);
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Date of Birth*"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.left,
                obscureText: true,
                onChanged: (value) {
                  //DO SOMETHING WHEN THE VALE IS CHANGED IN TEXT FIELD
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: "Password*"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.left,
                obscureText: true,
                onChanged: (value) {
                  //DO SOMETHING WHEN THE VALE IS CHANGED IN TEXT FIELD
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: " Conform Password*"),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: checkedStatus,
                    activeColor: Colors.lightGreen,
                    onChanged: (value) {
                      setState(() {
                        checkedStatus = value;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checkedStatus = !checkedStatus;
                      });
                    },
                    child: Text(
                      "I agree to terms and condition ",
                    ),
                  ),
                ],
              ),
              Center(
                child: RoundedButton(
                  onPressed: () {},
                  colour: Colors.green,
                  title: "Sign Up",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );

                    /// IMPLLEMENTATION OF FORGOT PASSWORD
                  },
                  child: Text("Sign in instead"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
