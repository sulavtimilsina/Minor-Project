class Product {
  String imageUrl;
  String name;
  String price;
  String details;
  String features;

  Product({this.imageUrl, this.name, this.price, this.details, this.features});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        imageUrl: json['imageUrl'],
        name: json['name'],
        price: json['price'],
        details: json['details'],
        features: json['features']);
  }
}
