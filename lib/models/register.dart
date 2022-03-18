import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) =>
    RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  RegisterRequestModel({
    this.name,
    this.isVerify = false,
    this.qualification,
    this.deviceId = '12345',
    this.email,
    this.contact_number,
    this.dob,
    this.password,
    this.role = '2',
    this.speciality,
    this.userType,
    this.img = null,
  });

  String? name;
  bool? isVerify;
  String? qualification;
  String? deviceId;
  String? email;
  String? contact_number;
  String? dob;
  String? password;
  String? role;
  String? speciality;
  String? userType;
  dynamic img;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        name: json["name"],
        isVerify: json["is_verify"],
        qualification: json["qulification"],
        deviceId: json["device_Id"],
        email: json["email"],
        contact_number: json["contact_number"],
        dob: json["dob"],
        password: json["password"],
        role: json["role"],
        speciality: json["speciality"],
        userType: json["userType"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_verify": isVerify,
        "qulification": qualification,
        "device_Id": deviceId,
        "email": email,
        "contact_number": contact_number,
        "dob": dob,
        "password": password,
        "role": role,
        "speciality": speciality,
        "userType": userType,
        "img": img,
      };
}

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.isOtpSent,
    this.msg,
    this.userId,
  });

  bool? isOtpSent;
  String? msg;
  String? userId;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        isOtpSent: json["isOTPSent"],
        msg: json["msg"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "isOTPSent": isOtpSent,
        "msg": msg,
        "user_id": userId,
      };
}
