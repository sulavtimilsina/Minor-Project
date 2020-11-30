class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String userType;
  final String message;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.userType,
      this.message});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        username: json['username'],
        message: json['message'],
        userType: json['userType']);
  }
}
