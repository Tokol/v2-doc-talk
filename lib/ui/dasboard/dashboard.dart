import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dashboard_data.dart';
import '../../models/dasboard_data_model.dart';
import '../../models/otp_verification.dart';
import '../../shared_pref/shared_pref.dart';
import '../../shared_pref/shared_pref_const.dart';

class DashBoardScreen extends StatefulWidget {

  static final String route = "/dashboard";

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late DashboardDataModel dashboardDataModel;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<void>(
        future: _loadDashBoardData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot){
      return ChangeNotifierProvider<DashBoardData>(
        create: (context)=>DashBoardData(dashboardDataModel: dashboardDataModel),
        //TODO @Ravi Magar
        child: Container()
      );
    });
  }

  Future<void> _loadDashBoardData() async {
    var accessToken = await PrefUtils.getString(ACCESS_TOKEN, '');
    var userDetail = await PrefUtils.getString(USER_DETAIL, '');

    User userDetails = User.fromJson(jsonDecode(userDetail));

   setState(() {
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

   });






  }
}



