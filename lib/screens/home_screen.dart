import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          elevation: 0.0,
          leading: Icon(Icons.sort),
          actions: <Widget>[
            Icon(Icons.notifications_none)
          ],
          title: Text('WALLET'),
          backgroundColor: Color.fromRGBO(17, 56, 92,3),
        ),
        body: Container(
          
          child: Column(
            children: <Widget>[
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(17, 56, 92,3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)

                  )
                  
                ),
                child: Center(
                  child: Text("22000",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40
                    ),)
                  ),
              )
              ,
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(105, 105, 105, 1),
                                  blurRadius: 20,
                                  offset: Offset(0,10)
                                )]
                    
                  ),
                ),
              )
              ,
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(105, 105, 105, 1),
                                  blurRadius: 20,
                                  offset: Offset(0,10)
                                )]
                    
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
