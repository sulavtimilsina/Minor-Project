class DoctorRecord {
  final String id;
  final String username;
  final String email;
  final String password;
  final String userType;
  final String message;

  DoctorRecord(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.userType,
      this.message});

  factory DoctorRecord.fromJson(Map<String, dynamic> json) {
    return DoctorRecord(
        id: json['_id'], username: json['username'], message: json['message'],userType: json['userType']);
  }
}
