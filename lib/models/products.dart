// class Product {
//   String imageUrl;
//   String name;
//   String price;
//   String details;
//   String features;

//   Product({this.imageUrl, this.name, this.price, this.details, this.features});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//         imageUrl: json['imageUrl'],
//         name: json['name'],
//         price: json['price'],
//         details: json['details'],
//         features: json['features']);
//   }
// }

class Product {
  String id;
  String imageUrl;
  String name;
  String price;
  String details;
  String features;

  Product(
      {this.id,
      this.imageUrl,
      this.name,
      this.price,
      this.details,
      this.features});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        imageUrl = json['imageUrl'],
        name = json['name'],
        price = json['price'],
        details = json['details'],
        features = json['features'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'details': details,
      'features': features
    };
  }
}
