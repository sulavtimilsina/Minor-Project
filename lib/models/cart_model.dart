class Cart {
  String imageUrl;
  String name;
  String price;
  String details;
  String features;

  Cart({this.imageUrl, this.name, this.price, this.details, this.features});

  Cart.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        name = json['name'],
        price = json['price'],
        details = json['details'],
        features = json['features'];

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'details': details,
      'features': features
    };
  }
}
