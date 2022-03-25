import 'dart:convert';

import 'package:doc_talk/models/dasboard_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/otp_verification.dart';
import '../networks/api_client.dart';
import '../shared_pref/shared_pref.dart';
import '../shared_pref/shared_pref_const.dart';

class DashboardDataController extends GetxController {
  final dashboardDataModal = DashboardDataModel().obs;
  final fileImage = "".obs;



  void updateDashboardData(DashboardDataModel updatedDashboardDataModel){
      dashboardDataModal.update((newDashboardValue) {
        dashboardDataModal.value = updatedDashboardDataModel;
      });
  }

  void updateFileImage(String imageFile){
    fileImage.update((newDashboardValueImg) {
      fileImage.value = imageFile;

    });
  }




}