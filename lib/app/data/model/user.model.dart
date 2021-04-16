class UserModel {
  String uid;
  String email;
  String username;
  DateTime createdAt;
  bool isEmailVerified;

  UserModel({this.email, this.createdAt, this.isEmailVerified, this.uid, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.uid = json['uid'] ?? "";
    this.username = json['username'] ?? "";
    this.email = json['email'] ?? "";
    this.createdAt = json['createdAt'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['isEmailVerified'] = this.isEmailVerified;
    return data;
  }
}
