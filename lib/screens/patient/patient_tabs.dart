import 'package:flutter/material.dart';   
import 'package:helloflutter/models/patient_tab_item.dart';


class PatientTabsPage extends StatefulWidget {
  @override
  _PatientTabsPageState createState() => _PatientTabsPageState();
}

class _PatientTabsPageState extends State<PatientTabsPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              // ignore: deprecated_member_use
              title: tabItem.title,
              backgroundColor: Colors.blue
            )
        ],
      ),
    );
  }
}