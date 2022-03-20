import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dashboard_data.dart';
import '../../helper/utils.dart';
import '../../models/dasboard_data_model.dart';
import '../../models/otp_verification.dart';
import '../../shared_pref/shared_pref.dart';
import '../../shared_pref/shared_pref_const.dart';
import 'dashbaordPages/chat/chat_screen.dart';
import 'dashbaordPages/dash.dart';

class DashboardRoute extends StatefulWidget {
  static final String route = "/mainPage";

  @override
  State<DashboardRoute> createState() => _DashboardRouteState();
}

class _DashboardRouteState extends State<DashboardRoute> {

  late DashboardDataModel dashboardDataModel;
  late final Future _myFuture = _loadDashBoardData(context);
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<void>(
      future: _myFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot){
          return ChangeNotifierProvider<DashBoardData>(
            create: (context)=>DashBoardData(dashboardDataModel: dashboardDataModel),
      child: Navigator(
          key: Utils.mainDashNav,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings){
            late Widget page;
            switch (settings.name){
              case '/':
                page = DashBoardHomeScreen();
                break;


              case '/chat':
                page = ChatScreen();
                break;

            }
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => page,
                transitionDuration: const Duration(seconds: 0)
            );



          },
        ),
      );
        }
    );
  }

  Future<void> _loadDashBoardData(BuildContext context) async {


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

    print(dashboardDataModel.id);

    var data  =  Provider.of<DashBoardData>(context, listen: false);

    data.upDateDashboardData(dashboardDataModel);


  }
}
