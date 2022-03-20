import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:doc_talk/models/login_model.dart';
import 'package:doc_talk/models/otp_verification.dart';
import 'package:doc_talk/models/register.dart';
import 'package:doc_talk/networks/api_constants.dart';
import 'package:doc_talk/shared_pref/shared_pref.dart';
import 'package:doc_talk/shared_pref/shared_pref_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/resend_otp.dart';

class ApiClient {
  Dio getApiClient() {
    Dio _dio = Dio();
    _dio.options = BaseOptions(connectTimeout: 50000, receiveTimeout: 50000);
    _dio.interceptors.clear();
    _dio.options.baseUrl = BASE_URL;
    return _dio;
  } //

  User? usermodel;

  User? get user => usermodel;
  set user(User? value) {
    usermodel = value;
  }
  //register a user

  Future<RegisterResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    Dio _dio = getApiClient();
    print(registerRequestModel.toJson());
    var response =
        await _dio.post(REGISTER_URL, data: registerRequestModel.toJson());


    final RegisterResponseModel registerResponseModel =
        RegisterResponseModel.fromJson(response.data);

    print(registerRequestModel);
    return registerResponseModel;
  }

  // for verify otp
  Future<OtpResponseModel> otpVerify(
      String userId, OtpRequestModel otpRequestModel) async {
    Dio _dio = getApiClient();

    var response = await _dio.post(VERIFY_OTP_URL + userId,
        data: otpRequestModel.toJson());

    print (response);
    OtpResponseModel userDetails;
    try{
      userDetails =
          OtpResponseModel.fromJson(response.data);
      var value = userDetails.user!.toJson();
      await PrefUtils.putString(USER_DETAIL, jsonEncode(value));
      await PrefUtils.putString(ACCESS_TOKEN, userDetails.token.toString());
      usermodel = userDetails.user;
      return userDetails;
    }

    catch(e){
      userDetails= OtpResponseModel.fromJson({
      "msg": response.data["msg"],
      "token": "null",
        "user":User(),
      });
      return userDetails;
    }

  }

  //For login
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    Dio _dio = getApiClient();
    SharedPreferences preferences = await SharedPreferences.getInstance();
     LoginResponseModel loginResponseModel;
    try{
      var response = await _dio.post(LOGIN_URL, data: loginRequestModel.toJson());

      loginResponseModel =
      LoginResponseModel.fromJson(response.data);

      print(response.data);
      print(response.data['email']);

      await PrefUtils.putString(ACCESS_TOKEN, loginResponseModel.token ?? '');
      //

      Map<String,dynamic> responseMap = {
        "_id":response.data['user'],
        "contact_number":response.data['contactNumber'],
        "email":response.data['email'],
      };

      await PrefUtils.putString(USER_ID, response.data['user'] ?? '');

    //  await PrefUtils.putString(USER_DETAIL, jsonDecode(responseMap.toString()));

     // print(responseMap);


     // await preferences.setBool("userLogIN", true);

      return loginResponseModel;
    }

    catch(e){
    loginResponseModel =
      LoginResponseModel.fromJson({
        "token": "invalid",
        "user": "invalid",
        "email": "invalid",
        "contactNumber": "invalid",
        "isNumberVerified": false,
        "msg": "invalid username or password",
      });
      return loginResponseModel;
    }



  }

  //for resend otp
  Future<ResendOtpResponseModel> resendOtpApi(
      ResendOtpRequestModel resendOtpRequestModel) async {
    Dio _dio = getApiClient();
    var response =
        await _dio.post(RESEND_OTP_URL, data: resendOtpRequestModel.toJson());
    return ResendOtpResponseModel.fromJson(response.data);




  }
}
