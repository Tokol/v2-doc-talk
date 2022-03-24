import 'dart:convert';

import 'package:doc_talk/models/dasboard_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/otp_verification.dart';
import '../networks/api_client.dart';
import '../shared_pref/shared_pref.dart';
import '../shared_pref/shared_pref_const.dart';

class DashBoardData  extends ChangeNotifier {
  DashboardDataModel dashboardDataModel = DashBoardData() as DashboardDataModel;


  void upDateDashboardData(DashboardDataModel dashboardDataModel){
    this.dashboardDataModel = dashboardDataModel;
    notifyListeners();
  }




  Future<DashboardDataModel> loadDashBoardData() async {

    var accessToken = await PrefUtils.getString(ACCESS_TOKEN, '');
    var userDetail = await PrefUtils.getString(USER_DETAIL, '');

    if(userDetail==''){

      var userID = await PrefUtils.getString(USER_ID, '');

      dashboardDataModel = DashboardDataModel(
        id: userID.toString(),
        accessToken: accessToken.toString(),
      );
    }

    else {
      User userDetails = User.fromJson(jsonDecode(userDetail));

        dashboardDataModel = DashboardDataModel(
          id: userDetails.id.toString(),
          accessToken: accessToken.toString(),
          fullName: userDetails.name.toString(),
          qualification: userDetails.qualification.toString(),
          speciality: userDetails.speciality.toString(),
          contactNumber: userDetails.contactNumber.toString(),
          email: userDetails.email.toString(),
          image: userDetails.img.toString(),
        );


    }

    print(dashboardDataModel.id);
    //
    // var data  =  Provider.of<DashBoardData>(context, listen: false);
    //
    // data.upDateDashboardData(dashboardDataModel);

    dashboardDataModel = await ApiClient().getUserDetail(userID: dashboardDataModel.id, accessToken: dashboardDataModel.accessToken);



    notifyListeners();

    return dashboardDataModel;
  }




}