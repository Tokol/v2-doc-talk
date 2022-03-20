import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel(
      {this.token,
      this.user,
      this.email,
      this.contactNumber,
      this.isNumberVerified,
      this.msg});

  String? token;
  String? user;
  String? email;
  String? contactNumber;
  bool? isNumberVerified;
  String? msg;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
        user: json["user"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        isNumberVerified: json["isNumberVerified"],
        msg: json["msg"],
      );
}

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    this.email,
    this.deviceId = "12345",
    this.password,
  });

  String? email;
  String? deviceId;
  String? password;


  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        email: json["email"],
        deviceId: json["device_id"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email,
      "device_id": deviceId,
      "password": password,
    };
    return map;
  }
}
