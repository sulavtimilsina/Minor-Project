import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:helloflutter/models/products.dart';
import 'package:helloflutter/screens/patient/widgets/product_container.dart';
import 'package:http/http.dart' as http;

Future<String> shopProduct(List<Product> cart) async {
  print(cart);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final http.Response response =
      await http.post('http://10.0.2.2:3000/products/shop',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: value
          },
          body: cart);
  if (response.statusCode == 200) {
    print(response.headers['x-auth-token']);
    final user = jsonDecode(response.body);
    //print(user.id);
    return user;
  } else {
    //print(response.body);
    final message = jsonDecode(response.body);
    // return message;
    print(message.message);
    throw Exception(message.message);
  }
}

// ignore: must_be_immutable
class Cart extends StatelessWidget {
  List<Product> cart;

  Cart({this.cart});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidht = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text("Cart"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: (cart != null
                  ? GridView.count(
                      childAspectRatio: itemHeight / itemWidht,
                      crossAxisCount: 2,
                      children: List.generate(
                        cart.length,
                        (index) {
                          return Container(
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                //borderRadius: BorderRadius.circular(80.0)
                                ),
                            child: ProductContainer(
                              product: cart[index],
                            ),
                          );
                        },
                      ))
                  : Text('No item in cart'))),
        ),
        InkWell(
          onTap: () {
            print(cart);
            shopProduct(cart);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                'Shop',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
