import 'dart:convert';

import 'package:doc_talk/ui/dasboard/dashbaordPages/chat/chat_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../controller/dashboard_data_controller.dart';
import '../../data/dashboard_data.dart';
import '../../helper/utils.dart';
import '../../models/dasboard_data_model.dart';
import '../../models/otp_verification.dart';
import '../../networks/api_client.dart';
import '../../shared_pref/shared_pref.dart';
import '../../shared_pref/shared_pref_const.dart';
import 'dashbaordPages/chat/chat_screen.dart';
import 'dashbaordPages/dash.dart';
import 'dashbaordPages/dash_list_views/recent_chat_list.dart';
import 'dashbaordPages/profile/profile.dart';

class DashboardHomeScreen extends StatefulWidget {
  static final String route = "/mainPage";

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  @override
  void initState() {
     loadDashBoardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DashboardDataController _controller = Get.put(DashboardDataController());
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        Positioned(

            top: MediaQuery.of(context).size.height * 0.01,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: AppBar().preferredSize.height),

              child:
              Obx(() =>_appbar(context,  _controller.dashboardDataModal.value))
              ),


        ),

        Positioned(
          child: Container(
            margin: EdgeInsets.only(top: AppBar().preferredSize.height-15),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
           // child:RecentChatList(recentMessageList: recentMessageList,),
          ),
          top: MediaQuery.of(context).size.height * 0.15,
          left: 0,
          right: 0,
          bottom: 0,
        ),
      ]),
    );

        }


  _appbar(BuildContext context, DashboardDataModel user) {
   if(user!=null){
     return Padding(
       padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           SizedBox(
             height: 70,
             width: 70,
             child: GestureDetector(
               onTap: (){
                 Get.to(UserProfile())?.then((value) async {
                   await loadDashBoardData();
                 });

               },

               child: user.image!= null?
               CircleAvatar(
                 backgroundColor: Colors.white,
                 radius: 50,
                 backgroundImage: NetworkImage(user.image!)
               ):
               CircleAvatar(
                   backgroundColor: Colors.white,
                   radius: 50,
                   child:Text(
                       user.fullName==null?
                       Utils.getShortCutOfString(longValue: "Null Value"):
                     Utils.getShortCutOfString(longValue: user.fullName!),
                         style: TextStyle(
                             fontSize: 30,
                             fontWeight: FontWeight.bold,
                             color: Theme.of(context).primaryColor),
                   )

               ),
             ),
           ),
           SizedBox(
             width: MediaQuery.of(context).size.width * 0.56,
           ),
           Expanded(
             child: Row(
               children:  [
                 IconButton(
                   onPressed: ()  {
                     Get.to(CreateChatGroup())?.then((value) async {
                       await loadDashBoardData();
                     });

                   },
                   icon: Icon( Icons.add,
                     color: Colors.white,
                     size: 30,),

                 ),
               ],
             ),
           ),
         ],
       ),
     );
   }

   else {
     return Container(child: Text('Loading...', style: TextStyle(color: Theme.of(context).primaryColor),),);
   }

  }

  }
Future<DashboardDataModel> loadDashBoardData() async {

 var dashboardValue = await PrefUtils.getString(DASHBOARD_VALUE,'' );

 DashboardDataModel dashboardDataModel;
 if(dashboardValue==''){
   dashboardDataModel = await fetchDataFromSharedPref();
   Get.find<DashboardDataController>().updateDashboardData(dashboardDataModel);
 }

 else {
   dashboardDataModel = DashboardDataModel().fromJson(jsonDecode(dashboardValue));

   print('priniting dashbmodal from pref');



   print(dashboardDataModel.id);
   Get.find<DashboardDataController>().updateDashboardData(dashboardDataModel);


 }

  bool internet = await Utils.checkInternet();
  if(internet){

    dashboardDataModel = await ApiClient().getUserDetail(userID: dashboardDataModel.id, accessToken: dashboardDataModel.accessToken);
    Get.find<DashboardDataController>().updateDashboardData(dashboardDataModel);

  }



  return dashboardDataModel;
}
Future<DashboardDataModel> fetchDataFromSharedPref() async {
      DashboardDataModel dashboardDataModel;
      var accessToken = await PrefUtils.getString(ACCESS_TOKEN, '');
      var userDetail = await PrefUtils.getString(USER_DETAIL, '');

      if(userDetail==''){

        var userID = await PrefUtils.getString(USER_ID, '');

        dashboardDataModel = DashboardDataModel(
          id: userID.toString(),
          accessToken: accessToken.toString(),
        );

        Get.find<DashboardDataController>().updateDashboardData(dashboardDataModel);
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

      return dashboardDataModel;

    }