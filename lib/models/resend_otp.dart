import 'dart:convert';

ResendOtpRequestModel otpRequestModelFromJson(String str) =>
    ResendOtpRequestModel.fromJson(json.decode(str));

String otpRequestModelToJson(ResendOtpRequestModel data) =>
    json.encode(data.toJson());

class ResendOtpRequestModel {
  ResendOtpRequestModel({
    this.contactNumber,
  });

  String? contactNumber;

  factory ResendOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      ResendOtpRequestModel(
        contactNumber: json["contact_number"],
      );

  Map<String, dynamic> toJson() => {
        "contact_number": contactNumber,
      };
}

ResendOtpResponseModel otpResponseModelFromJson(String str) =>
    ResendOtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(ResendOtpResponseModel data) =>
    json.encode(data.toJson());

class ResendOtpResponseModel {
  ResendOtpResponseModel({
    this.isOtpSent,
    this.msg,
  });

  bool? isOtpSent;
  String? msg;

  factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      ResendOtpResponseModel(
        isOtpSent: json["isOTPSent"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "isOTPSent": isOtpSent,
        "msg": msg,
      };
}
