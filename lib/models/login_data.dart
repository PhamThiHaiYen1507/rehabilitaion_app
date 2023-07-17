class LoginData {
  int? id;
  String? phoneNumber;
  String? password;
  bool? isDoctor;
  String? createAt;
  String? name;

  LoginData(
      {this.id,
      this.phoneNumber,
      this.password,
      this.isDoctor,
      this.createAt,
      this.name});

  LoginData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    isDoctor = json['isDoctor'];
    createAt = json['createAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['isDoctor'] = isDoctor;
    data['createAt'] = createAt;
    data['name'] = name;
    return data;
  }
}
