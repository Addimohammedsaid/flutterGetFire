class UserModel {
  String email;
  String uid;
  DateTime createdAt;

  UserModel({this.email, this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.uid = json['uid'];
    this.email = json['email'];
    this.createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
