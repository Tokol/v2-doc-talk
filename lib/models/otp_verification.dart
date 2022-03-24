import 'dart:convert';

OtpRequestModel otpRequestModelFromJson(String str) =>
    OtpRequestModel.fromJson(json.decode(str));

String otpRequestModelToJson(OtpRequestModel data) =>
    json.encode(data.toJson());

class OtpRequestModel {
  OtpRequestModel({
    this.otp,
    this.deviceId,
  });

  String? otp;
  String? deviceId;

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) =>
      OtpRequestModel(
        otp: json["otp"],
        deviceId: json["device_id"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "device_id": deviceId,
      };
}

OtpResponseModel otpResponseModelFromJson(String str) =>
    OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) =>
    json.encode(data.toJson());

class OtpResponseModel {
  OtpResponseModel({
    this.msg,
    this.token,
    this.user,
  });

  String? msg;
  String? token;
  User? user;

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    try {
     return OtpResponseModel(
        msg: json["msg"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );
    }

    catch (e) {
      return OtpResponseModel(
        msg: json["msg"],
        token: json["token"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "token": token,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.deviceId,
    this.id,
    this.name,
    this.email,
    this.qualification,
    this.contactNumber,
    this.password,
    this.role,
    this.speciality,
    this.isNumberVerified,
    this.phoneNumberOtp,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<dynamic>? deviceId;
  String? id;
  String? name;
  String? email;
  String? qualification;
  String? contactNumber;
  String? password;
  int? role;
  String? speciality;
  bool? isNumberVerified;
  String? phoneNumberOtp;
  String? img;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        deviceId:  json["device_id"]!=null?List<dynamic>.from(json["device_id"].map((x) => x)):null,
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        qualification: json["qualification"],
        contactNumber: json["contact_number"],
        password: json["password"],
        role: json["role"],
        speciality: json["speciality"],
        isNumberVerified: json["isNumberVerified"],
        phoneNumberOtp: json["phoneNumberOTP"],
        img: json["img"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "device_id": List<dynamic>.from(deviceId!.map((x) => x)),
        "_id": id,
        "name": name,
        "email": email,
        "qualification": qualification,
        "contact_number": contactNumber,
        "password": password,
        "role": role,
        "speciality": speciality,
        "isNumberVerified": isNumberVerified,
        "phoneNumberOTP": phoneNumberOtp,
        "img": img,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
