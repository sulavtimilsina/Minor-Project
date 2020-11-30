class Users {
  String id;
  String name;
  String email;

  Users(String id, String name, String email) {
    this.id = id;
    this.name = name;
    this.email = email;
  }

  Users.fromJson(Map json)
      : id = json['_id'],
        name = json['username'],
        email = json['email'];

  Map toJson() {
    return {'_id': id, 'username': name, 'email': email};
  }
}
