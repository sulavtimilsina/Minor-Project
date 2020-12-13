import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helloflutter/screens/doctor/consultaioin_screen.dart';
import 'package:helloflutter/screens/doctor/home_screen.dart';
import 'package:helloflutter/screens/doctor/schedule_screen.dart';
import 'package:helloflutter/screens/doctor/clinic_screen.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: DoctorHome(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page: ClinicPage(),
          icon: Icon(Icons.local_hospital_outlined),
          title: Text("Clinc"),
        ),
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.schedule),
          title: Text("Schedule"),
        ),
          TabNavigationItem(
          page: ConstultaionScreen(),
          icon: Icon(Icons.chat_bubble_outline_rounded),
          title: Text("Constultaion"),
        ),
      ];
}
