class Pdf {
  final String url;
  Pdf({this.url});

  factory Pdf.fromJson(Map<String, dynamic> json) {
    return Pdf(url: json['url']);
  }
}
