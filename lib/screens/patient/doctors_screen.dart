import 'dart:convert';
import '../../models/speciality.dart';
import 'package:flutter/material.dart';
import 'package:helloflutter/api/api.dart';
import 'package:helloflutter/models/users_model.dart';



class Doctors extends StatefulWidget {
  
  final Speciality speciality;
  Doctors({Key key, @required this.speciality}) : super(key: key);
  @override
  _DoctorsState createState() => _DoctorsState();
  
  
}

class _DoctorsState extends State<Doctors> {
  var users = new List<Users>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => Users.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Health"),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(users[index].name));
          },
        ));
  }
}
