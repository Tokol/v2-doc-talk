import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:doc_talk/helper/utils.dart';
import 'package:doc_talk/models/login_model.dart';
import 'package:doc_talk/models/otp_verification.dart';
import 'package:doc_talk/models/register.dart';
import 'package:doc_talk/networks/api_constants.dart';
import 'package:doc_talk/shared_pref/shared_pref.dart';
import 'package:doc_talk/shared_pref/shared_pref_const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/dashboard_data_controller.dart';
import '../helper/jsonfilters.dart';
import '../models/chat_group_message.dart';
import '../models/chat_group_modal.dart';
import '../models/dasboard_data_model.dart';
import '../models/patient_model.dart';
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

    var response =
        await _dio.post(REGISTER_URL, data: registerRequestModel.toJson());

    final RegisterResponseModel registerResponseModel =
        RegisterResponseModel.fromJson(response.data);


    return registerResponseModel;
  }

  // for verify otp
  Future<OtpResponseModel> otpVerify(
      String userId, OtpRequestModel otpRequestModel) async {
    Dio _dio = getApiClient();

    var response = await _dio.post(VERIFY_OTP_URL + userId,
        data: otpRequestModel.toJson());


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

  Future<dynamic> requestPhonenumberForForgetPassword(
      String phoneNumber) async {
    //REQUEST_PHONE_NUMBER_FORGET_PASSWORD
    Dio _dio = getApiClient();

    var response = await _dio.post(REQUEST_PHONE_NUMBER_FORGET_PASSWORD, data: {
      'contact_number': phoneNumber.toString(),
    });

    return response.data;
  }

  Future<dynamic> changePasswordFromPhoneRequest(
      {required String otp,
      required String id,
      required String newPass,
      required String confirmPass}) async {
    //REQUEST_PHONE_NUMBER_FORGET_PASSWORD
    Dio _dio = getApiClient();


    var response = await _dio.post(Change_PASSWORD_FROM_FORGET_REQUEST, data: {
      'newPassword': newPass,
      'confirmPassword': confirmPass,
      'otp': otp.toString(),
      'id': id,
    });

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

  Future<dynamic> searchUserFromPhoneContacts(
      {required String accessToken, required List<String> contacts}) async {
    Dio _dio = getApiClient();
    _dio.options.headers["x-access-token"] = accessToken;

    var response = await _dio.post(
      GET_USER_LIST_FROM_CONTACTS,
      data: {
        'numbers': contacts,
      },
    );

    return response.data;
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
      //print(e.toString());
    }
  }

  Future<List<ChatGroupModel>> getUserChatGroups(
      {required String accessToken, required String phoneNumber}) async {
    List<ChatGroupModel> chatGroupModel = [];
    Dio _dio = getApiClient();
    _dio.options.headers["x-access-token"] = accessToken;

    try {
      var response = await _dio.get(GET_USER_CHAT_GROUPS + phoneNumber,
          options: Options(
              method: 'GET',
              responseType: ResponseType.plain // or ResponseType.JSON
              ));

      var result = json.decode(response.data);

      var data = result["data"];

      chatGroupModel = JsonFilters().getChatGroups(data);

      await PrefUtils.putString(USER_CHAT_GROUP, jsonEncode(data));
      return chatGroupModel;
    } catch (e) {
      print(e);
      print('worng');
      return chatGroupModel;
      //print(e.toString());
    }
  }

  Future<dynamic> createChatGroup(
      {required String groupName,
      required String accessToken,
      required String contactNumber}) async {
    var _dio = new Dio();
    _dio.options.baseUrl = CREATE_GROUP_CHAT;
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;
    _dio.options.headers["x-access-token"] = accessToken;

    Map<String, dynamic> requestParams = {
      "group_name": groupName,
      "admin": contactNumber,
    };

    FormData formData = new FormData.fromMap(requestParams);
    var response = await _dio.post(CREATE_GROUP_CHAT,
        data: formData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    return response.data;
  }

  Future<dynamic> addUserInGroup(
      {required String groupId,
      required String accessToken,
      required String contactNumber}) async {
    var _dio = new Dio();
    _dio.options.baseUrl = CREATE_GROUP_CHAT;
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;
    _dio.options.headers["x-access-token"] = accessToken;

    Map map = {"group_id": groupId, "user": contactNumber};
    var response = await _dio.put(CREATE_GROUP_CHAT,
        data: map,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    return response.data;
  }


  Future<List<ChatGroupMessage>> getMessagesOfGroup({required String accessToken, required String groupId, required int pageNumber}) async {
    List<ChatGroupMessage> chatMessageFromGroups = [];

    Dio _dio = getApiClient();
    _dio.options.baseUrl = GET_MESSAGE_FROM_GROUP;
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;
    _dio.options.headers["x-access-token"] = accessToken;
    Map map = {'group_id': groupId};
    String requestMessageUrl = '$GET_MESSAGE_FROM_GROUP$pageNumber&limit=10';
    var response = await _dio.post(requestMessageUrl,
        data: map,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));

          var data = response.data["data"]["resultMessages"];


          try{
            chatMessageFromGroups = JsonFilters().getChatMessageFromGroups(data);
          }
          catch(e){
            print(e);
          }



          return chatMessageFromGroups;

  }



  Future<List<ChatGroupUserTotal>> getTotalGroupMembersFromGroup({required String accessToken, required String groupId}) async {
    List<ChatGroupUserTotal> totalUserInGroup = [];

    Dio _dio = getApiClient();
    _dio.options.baseUrl = GET_TOTAL_GROUP_USER;
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;

    _dio.options.headers["x-access-token"] = accessToken;


    var map = {
      'group_id': groupId,
    };

    var response = await _dio.post(GET_TOTAL_GROUP_USER,
        data: map,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));
    var result = response.data["data"];
    for(int i=0; i<result.length; i++){
      String id = result[i]["_id"];
      String name = result[i]["name"];
      String email = result[i]["email"];
      String profileImage = result[i]["img"].toString();
      String contactNumber = result[i]["contact_number"];
      String speciality = result[i]["speciality"];

      totalUserInGroup.add(ChatGroupUserTotal(name: name, profileImage: profileImage, email: email, contactNumber: contactNumber, id: id, speciality: speciality));

    }
    return totalUserInGroup;
  }



  Future<String> getImagePathForChat({required String accessToken, required XFile image}) async{

    try {

      var _dio = new Dio();
      _dio.options.baseUrl = GET_IMAGE_PATH_FOR_CHAT_MESSAGE;
      _dio.options.connectTimeout = 500000; //5s
      _dio.options.receiveTimeout = 500000;
      _dio.options.headers["x-access-token"] = accessToken;

      FormData formData = new FormData.fromMap({
        "img": await MultipartFile.fromFile(image.path,
            filename: image.path.toString()),
      });

      var response = await _dio.post(GET_IMAGE_PATH_FOR_CHAT_MESSAGE,
          data: formData,
          options: Options(
              method: 'POST',
              responseType: ResponseType.plain // or ResponseType.JSON
          ));

      var result = json.decode(response.data);

      return result["imgUrl"];
    } catch (e) {
      print('wrong ');
      return "";
    }
  }



  Future<void> leaveGroup({String? accessToken, String? groupId, String? contactNumber}) async {

    Dio _dio = getApiClient();
    _dio.options.baseUrl = USER_LEAVE_GROUP;
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;

    _dio.options.headers["x-access-token"] = accessToken;

    Map map = {"email": contactNumber, "group_id": groupId};

    var response = await _dio.post(USER_LEAVE_GROUP,
        data: map,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));

    print(response.data);
  }



  Future<List<Patient>> getPatientFromGroup({String? accessToken, String? groupId}) async {
    List<Patient> patientList=[];
  Dio _dio = getApiClient();
  _dio.options.baseUrl = GET_All_PATIENT_LIST_Of_GROUP;
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;

  _dio.options.headers["x-access-token"] = accessToken;


  var response = await _dio.get('${GET_All_PATIENT_LIST_Of_GROUP}$groupId',
      options: Options(
          method: 'GET',
          responseType: ResponseType.json // or ResponseType.JSON
      ));


  dynamic result = response.data;

  if (result.containsKey('data')) {
    var data = result['data'];
    patientList = JsonFilters().getPatientListFromGroup(data);

  }

return  patientList;

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
    await PrefUtils.putString(USER_CHAT_GROUP, '');
    await UserProfile().logout();
  }
}
