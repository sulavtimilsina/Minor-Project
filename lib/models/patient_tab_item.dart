import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helloflutter/screens/patient/appointments_screen.dart';
import 'package:helloflutter/screens/patient/home_screen.dart';
import 'package:helloflutter/screens/patient/shop_screen.dart';
import 'users_model.dart';

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
          page:  PatientHome(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page:AppointmentScreen(),
          icon: Icon(Icons.person),
          title: Text("Appointment"),
        ),
        TabNavigationItem(
          page: ShopScreen(),
          icon: Icon(Icons.shop),
          title: Text("Shop"),
        ),

      ];
}
