import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:helloflutter/models/products.dart';
import 'package:helloflutter/screens/patient/product_details.dart';
import 'package:helloflutter/screens/patient/shopping_cart.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> getProducts() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http
      .get('http://10.0.2.2:3000/products/api', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: value
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var tagObjsJson = jsonDecode(response.body) as List;
    List<Product> tagObjs =
        tagObjsJson.map((tagJson) => Product.fromJson(tagJson)).toList();

    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Future<List<Product>> products;
  List<Product> cart = List<Product>();

  void initState() {
    super.initState();
    products = getProducts();
  }

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
        title: Text("Categories"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Cart(
                                    cart: cart,
                                  )));
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.add_shopping_cart),
                ),
                Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(child: Text(cart.length.toString())))
              ],
            ),
          )
        ],
      ),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white38),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [Icon(Icons.search), Text("Search")],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<Product>>(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                        childAspectRatio: itemHeight / itemWidht,
                        crossAxisCount: 2,
                        children: List.generate(
                          snapshot.data.length,
                          (index) {
                            print(snapshot.data[index].name);
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                                imageUrl: snapshot
                                                    .data[index].imageUrl,
                                                name: snapshot.data[index].name,
                                                price:
                                                    snapshot.data[index].price,
                                                details: snapshot
                                                    .data[index].details,
                                                features: snapshot
                                                    .data[index].features,
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      //color: Colors.white,
                                      //borderRadius: BorderRadius.circular(80.0)
                                      ),
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            child: Center(
                                                child: Image.network(
                                                    'http://10.0.2.2:3000/images/${snapshot.data[index].imageUrl}',
                                                    height: 100,
                                                    fit: BoxFit.scaleDown))),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                            "NRP. ${snapshot.data[index].price}"),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Text(
                                                    "WishList",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (cart.contains(
                                                        snapshot.data[index])) {
                                                      cart.remove(
                                                          snapshot.data[index]);
                                                    } else {
                                                      cart.add(
                                                          snapshot.data[index]);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.greenAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: (cart.contains(
                                                            snapshot
                                                                .data[index]))
                                                        ? Text(
                                                            "Remove",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Text(
                                                            "Add to Cart",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                  ),
                                ));
                          },
                        ));
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                }),
          ),
        ),
      ]),
    );
  }
}
