
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helloflutter/screens/doctor/home_screen.dart';
import 'package:helloflutter/screens/doctor/search_page.dart';

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
          page: SearchPage(),
          icon: Icon(Icons.search),
          title: Text("Search"),
        ),
      ];
}