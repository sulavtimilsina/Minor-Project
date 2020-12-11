import 'package:flutter/material.dart';
import 'package:helloflutter/models/products.dart';

// ignore: must_be_immutable
class ProductContainer extends StatefulWidget {
  Product product;

  ProductContainer({this.product});

  @override
  _ProductContainerState createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    List<Product> cart = List<Product>();
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Center(
                  child: Image.network(
                      'http://10.0.2.2:3000/images/${widget.product.imageUrl}',
                      height: 100,
                      fit: BoxFit.scaleDown))),
          Divider(
            color: Colors.black,
          ),
          Text(
            widget.product.name,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text("NRP. ${widget.product.price}"),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      "WishList",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cart.add(widget.product);
                    });
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
