import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  String imageUrl;
  String name;
  String price;
  String details;
  String features;

  ProductDetails(
      {this.imageUrl, this.name, this.price, this.details, this.features});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Center(
                    child: Image.network(
              'http://10.0.2.2:3000/images/$imageUrl',
              height: MediaQuery.of(context).size.height * 0.5,
            ))),
            Divider(
              color: Colors.black,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                details,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "NRP. $price",
              style: TextStyle(fontSize: 25.0, color: Colors.redAccent),
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              "Product Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(details),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "WishList",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
