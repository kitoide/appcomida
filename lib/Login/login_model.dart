class LoginModel {
  String name;
  String email;
  String image;
  String token;

  LoginModel({this.name, this.email, this.image, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}
