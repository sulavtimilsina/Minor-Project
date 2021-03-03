class Data {
  String imageUrl;

  Data({this.imageUrl});

  factory Data.fromJson(Map<String, dynamic> json) {
  
    return Data(imageUrl: json['imageUrl']);
  }
}
