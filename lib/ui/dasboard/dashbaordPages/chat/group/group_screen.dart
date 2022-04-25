import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../controller/dashboard_data_controller.dart';
import 'add_group.dart';
import 'chat_head_widget.dart';
import 'chat_body_widget.dart';

class GroupScreen extends StatelessWidget {

  bool fromChatSetting;
  GroupScreen({this.fromChatSetting=false});

  final DashboardDataController _controller =
  Get.put(DashboardDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          fromChatSetting?"Add To Group":"New Group",
          style: TextStyle(fontSize: 22.0),
        ),
        actions: [

     IconButton(icon: Icon(FontAwesomeIcons.check), onPressed: () {
      fromChatSetting==false? moveToNextScreen(): Get.back();
    })
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top:  AppBar().preferredSize.height*0.2),
          child: Column(
            children: [
              ChatHeaderWidget(), //chat_header_widget
              SizedBox(
                height: 5,
              ),
              ChatBodyWidget(), //chat_body_widget
            ],
          )),
    );
  }


  bool moveToNextScreen(){
Get.to(GroupAddScreen());
        return true;

  }




}