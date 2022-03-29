import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../controller/dashboard_data_controller.dart';
import '../../../../../helper/utils.dart';

// ignore: must_be_immutable
class ChatHeaderWidget extends StatelessWidget {

  final DashboardDataController _controller =
  Get.put(DashboardDataController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Obx((){
      if(_controller.chatGroupContact.value.length==0){
        return Container();
      }

      else {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: ListView.builder(
            itemBuilder: (BuildContext ctx, int index) {
              if(_controller.chatGroupContact.value[index].selected==true){
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: _controller.chatGroupContact.value[index].img=="null"?
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 38,
                    child:Text(
                      Utils.getShortCutOfString(longValue:_controller.chatGroupContact.value[index].fullName),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,),
                    ),):
                  CircleAvatar(
                    radius: 38,
                    backgroundImage: NetworkImage(_controller.chatGroupContact.value[index].img),
                    // backgroundImage: AssetImage(a[index]),
                  ),
                );
              }
              else {
                return SizedBox();
              }

            },
            itemCount: _controller.chatGroupContact.value.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      }
    }),

      ]),
    );
  }
}