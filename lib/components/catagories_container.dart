import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},

      ///GO TO SPECIALITIES PAGE
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: CircleAvatar(
                radius: 15.0,
                backgroundImage: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/000/504/427/original/vector-anesthesia-icon-design.jpg"),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Heart Suergeon",
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
