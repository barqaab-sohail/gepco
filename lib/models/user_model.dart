class UserModel {
  int? status;
  String? userName;
  String? email;
  String? token;
  String? message;

  UserModel({this.status, this.userName, this.email, this.token, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userName = json['userName'];
    email = json['email'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
