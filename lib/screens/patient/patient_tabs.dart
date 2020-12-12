import 'package:flutter/material.dart';
import 'package:helloflutter/models/patient_tab_item.dart';



class PatientTabsPage extends StatefulWidget {
  int _currentIndex = 0;
  PatientTabsPage(this._currentIndex);
  @override
  _PatientTabsPageState createState() => _PatientTabsPageState();
}

class _PatientTabsPageState extends State<PatientTabsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget._currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget._currentIndex,
        onTap: (int index) => setState(() => widget._currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              // ignore: deprecated_member_use
              title: tabItem.title,
            )
        ],
      ),
    );
  }
}