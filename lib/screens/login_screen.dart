import 'package:flutter/material.dart';

import './home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.black87,
                  Colors.black54,
                  Colors.black38,
                  
                ]
              )
            ),
            
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text('Sulav Ko Laxmi Bikas',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: Text('Manage all your funds',style: TextStyle(color: Colors.white,
                              fontSize: 18),),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60)
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 60,),
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(94, 88, 88, 3),
                                  blurRadius: 20,
                                  offset: Offset(0,10)
                                )]
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        
                                        prefixIcon: Icon(
                                          Icons.perm_identity,
                                          color:Colors.white,
                                        ),
                                        hintText: 'Email or Phone number',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock_outline,
                                          color: Colors.white,),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                            SizedBox(height: 25,),
                            Text("Forget Password",
                              style: TextStyle(color:Colors.grey),
                            ),
                            SizedBox(height: 25,),
                            Container(
                              height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white
                              ),
                              child: Center(
                                child: FlatButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                    
                                      MaterialPageRoute(builder: (context) => HomeScreen()),
                                      );
                                  },
                                    child: Text('Login',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold
                                    ),),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              
                              height: 45,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black
                              ),
                              child: Center(
                                
                                child: Text('Create Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ),
                  )
                  
                 
                ],
              ),
            ),
            
          
        
    );
  }
}
