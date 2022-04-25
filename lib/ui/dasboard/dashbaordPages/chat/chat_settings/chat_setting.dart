// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../controller/dashboard_data_controller.dart';
import '../../../../../helper/utils.dart';
import '../../../../../networks/api_client.dart';
import '../create_chat_group.dart';



class ChatSettings extends StatefulWidget {
  String chatGroupName;
  String chatGroupId;
  ChatSettings({required this.chatGroupName, required this.chatGroupId});

  @override
  _ChatSettingsState createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {

  final DashboardDataController _controller =
  Get.put(DashboardDataController());

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body:
          GroupEdit() // This trailing comma makes auto-formatting nicer for build methods.
      );

  }

  // ignore: non_constant_identifier_names
  Widget GroupEdit() {
    List<IconData> a = [
      Icons.call,
      Icons.video_call,
      Icons.group_add,
      Icons.notifications_off,
    ];
    return Column(children: [
      Center(
        child: Column(children: <Widget>[
          SizedBox(
            width: 125,
            height: 125,
            child:
            Stack(clipBehavior: Clip.none, fit: StackFit.expand, children: [
              Positioned(
                child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      shape: BoxShape.circle,
                      color: const Color(0xFF5A227E),
                    ),
                    child: Center(
                      child: Text(
                        Utils.getShortCutOfString(
                          longValue: widget.chatGroupName,
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    )),
              ),

            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.chatGroupName,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            '${_controller.totalUserInGroups.length} Participants',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: SizedBox(
              height: 10,
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 30,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ProfileListItem(
                icon: Icons.add,
                text: 'Add New Members',
                onTap: () {
                  Get.to(CreateChatGroup(fromChatSetting: true,))?.then((value) async {

                    for (int i=0; i<_controller.userChatGroups.length; i++){
                      if(_controller.chatGroupContact[i].selected){
                        //creatingFromContacts = true;
                        await ApiClient().addUserInGroup(groupId: widget.chatGroupId, accessToken: _controller.dashboardDataModal.value.accessToken!, contactNumber: _controller.chatGroupContact[i].contactNumber);
                        Get.back();
                      }

                    }
                          _controller.updateChatBackMessage(BackMessageTypeChat.USER_ADDED);
                        Get.back();
                    //print('oksss');
                  });
                },
              ),
              ProfileListItem(
                icon: Icons.group,
                text: 'See group Members',
                onTap: (){
                 // _controller.updateChatBackMessage("ok here it is");
                 Get.back();
                },
              ),
              ProfileListItem(
                icon: FontAwesomeIcons.fileArrowDown,
                text: 'View Archive Patients',
              ),

              ProfileListItem(
                icon: FontAwesomeIcons.arrowRightFromBracket,
                text: 'Leave group',
                onTap: (){
                  _controller.updateChatBackMessage(BackMessageTypeChat.GROUP_LEAVE);
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  // ignore: prefer_typing_uninitialized_variables
  final text;
  final bool hasNavigation;
  final Function? onTap;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        height: 50,
        margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 214, 210, 216)),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xff5A227E),
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff5A227E),
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (hasNavigation)
                Icon(
                  FontAwesomeIcons.angleRight,
                  size: 20,
                  color: Color(0xff5A227E),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
