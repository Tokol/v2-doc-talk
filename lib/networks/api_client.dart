import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:doc_talk/models/login_model.dart';
import 'package:doc_talk/models/otp_verification.dart';
import 'package:doc_talk/models/register.dart';
import 'package:doc_talk/networks/api_constants.dart';
import 'package:doc_talk/shared_pref/shared_pref.dart';
import 'package:doc_talk/shared_pref/shared_pref_const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dasboard_data_model.dart';
import '../models/resend_otp.dart';
import '../ui/dasboard/dashbaordPages/profile/profile.dart';

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

    print(response);
    OtpResponseModel userDetails;
    try {
      userDetails = OtpResponseModel.fromJson(response.data);
      var value = userDetails.user!.toJson();
      await PrefUtils.putString(USER_DETAIL, jsonEncode(value));
      await PrefUtils.putString(ACCESS_TOKEN, userDetails.token.toString());
      usermodel = userDetails.user;
      return userDetails;
    } catch (e) {
      userDetails = OtpResponseModel.fromJson({
        "msg": response.data["msg"],
        "token": "null",
        "user": User(),
      });
      return userDetails;
    }
  }


  Future<dynamic> requestPhonenumberForForgetPassword(String phoneNumber) async {
        //REQUEST_PHONE_NUMBER_FORGET_PASSWORD
    Dio _dio = getApiClient();

    var response = await _dio.post(REQUEST_PHONE_NUMBER_FORGET_PASSWORD, data: {
      'contact_number':phoneNumber.toString(),

    } );

   return response.data;

  }

  Future<dynamic> changePasswordFromPhoneRequest({required String otp, required String id, required String newPass, required String confirmPass}) async {
    //REQUEST_PHONE_NUMBER_FORGET_PASSWORD
    Dio _dio = getApiClient();

    print(id);

    var response = await _dio.post(Change_PASSWORD_FROM_FORGET_REQUEST, data: {
      'newPassword': newPass,
      'confirmPassword': confirmPass,
      'otp': otp.toString(),
      'id': id,
    } );

    return response.data;

  }



  //For login
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    Dio _dio = getApiClient();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    LoginResponseModel loginResponseModel;
    try {
      var response =
          await _dio.post(LOGIN_URL, data: loginRequestModel.toJson());

      loginResponseModel = LoginResponseModel.fromJson(response.data);

      print(response.data);
      print(response.data['email']);

      await PrefUtils.putString(ACCESS_TOKEN, loginResponseModel.token ?? '');
      //

      Map<String, dynamic> responseMap = {
        "_id": response.data['user'],
        "contact_number": response.data['contactNumber'],
        "email": response.data['email'],
      };

      await PrefUtils.putString(USER_ID, response.data['user'] ?? '');

      return loginResponseModel;
    } catch (e) {
      loginResponseModel = LoginResponseModel.fromJson({
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

  Future<DashboardDataModel> getUserDetail(
      {String? userID, String? accessToken}) async {
    DashboardDataModel dashboardDataModel;
    try {
      Dio _dio = getApiClient();
      _dio.options.headers["x-access-token"] = accessToken;

      var response = await _dio.get(GET_USER_DETAIL + userID!);

      if (response.data["data"] != null) {
        dashboardDataModel = DashboardDataModel(
          accessToken: accessToken,
          id: response.data["data"]["_id"],
          fullName: response.data["data"]["name"],
          email: response.data["data"]["email"],
          speciality: response.data["data"]["speciality"],
          contactNumber: response.data["data"]["contact_number"],
          image: response.data["data"]["img"],
        );

        await PrefUtils.putString(
            DASHBOARD_VALUE, jsonEncode(dashboardDataModel.toJson()));

        return dashboardDataModel;
      } else {
        dashboardDataModel = DashboardDataModel();
        logout(accessToken: accessToken);
      }
      return dashboardDataModel;
    } catch (e) {
      dashboardDataModel = DashboardDataModel();
      logout(accessToken: accessToken);
      return dashboardDataModel;
    }
  }

  Future<dynamic> changeUserProfileImage(
      {required String accessToken,
      required String userId,
      required XFile image}) async {
    var _dio = new Dio();
    _dio.options.baseUrl = CHANGE_USER_PROFILE_IMAGE;
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;
    _dio.options.headers["x-access-token"] = accessToken;
    FormData formData = new FormData.fromMap({
      "img": await MultipartFile.fromFile(image.path,
          filename: image.path.toString()),
    });

    print(CHANGE_USER_PROFILE_IMAGE);
    var response = await _dio.put(CHANGE_USER_PROFILE_IMAGE,
        data: formData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.plain // or ResponseType.JSON
            ));

    print(json.decode(response.data));

    return json.decode(response.data);
  }

  Future<dynamic> updateUserProfileDetail(
      {required Map<String, dynamic> map,
      required String accessToken,
      required String userId}) async {
    Dio _dio = getApiClient();
    _dio.options.headers["x-access-token"] = accessToken;

    var response = await _dio.put(CHANGE_USER_PROFILE_DETAIL,
        data: map,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.plain // or ResponseType.JSON
            ));

    return json.decode(response.data);
  }


  Future<void> searchUserFromPhoneContacts({required String accessToken,required List<String> contacts }) async {
    Dio _dio = getApiClient();
    _dio.options.headers["x-access-token"] = accessToken;

    var response = await _dio.post(GET_USER_LIST_FROM_CONTACTS, data: {
      'numbers': contacts,
    },

    options: Options(
      method: 'POST',
      responseType: ResponseType.plain,
    ),);

    print(response);

    return json.decode(response.data);
  }



  Future<void> changePassword(
      {required Map<String, dynamic> map, required String accessToken}) async {
    Dio _dio = getApiClient();
    _dio.options.headers["x-access-token"] = accessToken;
    try {
      var response = await _dio.put(CHANGE_USER_PASSWORD,
          data: map,
          options: Options(
              method: 'PUT',
              responseType: ResponseType.plain // or ResponseType.JSON
              ));

      var result = json.decode(response.data);

      if (result["isSuccess"] == true) {
        await logout(accessToken: accessToken);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logout({String? accessToken}) async {
    Dio _dio = getApiClient();
    _dio.options.headers["x-access-token"] = accessToken;

    await _dio.post(
      USER_LOG_OUT,
    );

    await PrefUtils.putString(ACCESS_TOKEN, '');
    await PrefUtils.putString(USER_ID, '');
    await PrefUtils.putString(USER_DETAIL, '');
    await PrefUtils.putString(DASHBOARD_VALUE, '');
    await UserProfile().logout();
  }
}
