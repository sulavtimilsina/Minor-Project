import 'package:flutter/material.dart';
import 'package:helloflutter/data/category.dart';
import 'package:helloflutter/models/category_model.dart';
import 'package:helloflutter/screens/patient/products_screen.dart';

class ShopScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ShopScreen(),
      );

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Category> categories;

  @override
  void initState() {
    super.initState();

    categories = getCategory();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidht = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          leading: Icon(Icons.sort),
          title: Text("Categories"),
        ),
        SliverToBoxAdapter(
          child: Container(
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
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                print(categories[index].name);
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Products()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(80.0)
                    ),
                    child: Specialist(
                        imgAssetPath: categories[index].imgAssetPath,
                        name: categories[index].name),
                  ),
                );
              }, childCount: categories.length),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  //mainAxisSpacing: 100.0,
                  //crossAxisSpacing: 10.0,
                  childAspectRatio: (itemWidht / itemHeight))),
        ),
      ]),
    );
  }
}

// ignore: must_be_immutable
class Specialist extends StatelessWidget {
  String imgAssetPath;
  String name;
  Specialist({this.imgAssetPath, this.name});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imgAssetPath,
              height: 100,
              fit: BoxFit.scaleDown,
            ),
            Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
