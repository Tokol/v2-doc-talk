import 'package:doc_talk/models/otp_verification.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/dashboard_data.dart';
import '../../../helper/utils.dart';
import '../../../models/dasboard_data_model.dart';
import '../../../models/recent_message_model.dart';
import '../dashboard_home.dart';
import 'dash_list_views/recent_chat_list.dart';

class DashBoardHomeScreen extends StatefulWidget {
  @override
  State<DashBoardHomeScreen> createState() => _DashBoardHomeScreenState();
}




class _DashBoardHomeScreenState extends State<DashBoardHomeScreen> {


  List<RecentMessageModel> recentMessageList = [];

  @override
  Widget build(BuildContext context) {
    recentMessageList.add(RecentMessageModel( lastMessage: 'check urine', timeStamp: '17:31', lastMessageBy: 'Suresh', groupName: 'Health Care Hospital', ));
    recentMessageList.add(RecentMessageModel( lastMessage: 'ok guys lets meet ', timeStamp: '23:55', lastMessageBy: 'You', groupName: 'Hams Psyc Ward 30', ));
    recentMessageList.add(RecentMessageModel( lastMessage: 'hello, all', timeStamp: '6:10', lastMessageBy: 'Sujan', groupName: 'Karuna Clinic Gyno Ward 30', ));
    recentMessageList.add(RecentMessageModel( lastMessage: 'ayeshaaa', timeStamp: '5:9', lastMessageBy: 'Rajesh', groupName: 'Teaching Hospital ward Dermotology', ));
    User user = User();
    return Consumer<DashBoardData>(
        builder: (context, data, child) {

          return FutureBuilder<DashboardDataModel>(
            future: data.loadDashBoardData(),
            builder: (BuildContext context,
                AsyncSnapshot<DashboardDataModel> snapshot){
              return Container();
              //
            },
          );
        }

    );
  }

  _appbar(BuildContext context, User user) {
    // var data  =  Provider.of<DashBoardData>(context, listen: false);
    // print(data.dashboardDataModel.fullName);

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: user.img != null
                  ? Image.network(user.img.toString())
                  : Text(
                      user.name.toString().substring(0, 1).toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
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
               Utils.mainDashNav.currentState!.pushReplacementNamed('/chat').then((value) => DashboardHomeScreen());

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
}
