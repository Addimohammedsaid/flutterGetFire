class UserModel {
  String email;
  String username;
  String uid;
  DateTime createdAt;

  UserModel({this.email, this.createdAt});

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
    return data;
  }
}
