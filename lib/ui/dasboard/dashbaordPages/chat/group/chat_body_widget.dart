import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import '../../../../../controller/dashboard_data_controller.dart';
import '../../../../../helper/utils.dart';
import '../create_chat_group.dart';

class ChatBodyWidget extends StatefulWidget {
  @override
  _ChatBodyWidget createState() => _ChatBodyWidget();
}

class _ChatBodyWidget extends State<ChatBodyWidget> {
  final DashboardDataController _controller =
      Get.put(DashboardDataController());

  Iterable<ContactUserInApp> filterContactUserInAppList = [];

  bool filter = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (_controller.chatGroupContact.value.length == 0) {
                  return Expanded(child: Container());
                } else {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: OutlineSearchBar(
                      onKeywordChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            filter = false;
                          });
                        } else {
                          setState(() {
                            filter = true;
                            filterContactUserInAppList = _controller
                                .chatGroupContact.value
                                .where((element) => element.fullName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()));
                          });
                        }
                      },
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      hintText: "Search for people to add",
                      backgroundColor: const Color(0xFFE5E5E5),
                    ),
                  );
                }
              }),
              Obx(() {
                if (_controller.chatGroupContact.value.length == 0) {
                  return Expanded(child: Container());
                } else {
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        //filterContactUserInAppList
                        ContactUserInApp contactUserInApp;
                        if (filter) {
                          contactUserInApp =
                              filterContactUserInAppList.elementAt(index);
                        } else {
                          contactUserInApp =
                              _controller.chatGroupContact.value[index];
                        }

                        return ListTile(
                          tileColor: Colors.grey,
                          leading: contactUserInApp.img == "null"
                              ? CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  radius: 30,
                                  child: Text(
                                    Utils.getShortCutOfString(
                                        longValue: contactUserInApp.fullName),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(contactUserInApp.img)),
                          title: Text(contactUserInApp.fullName),
                          subtitle: Text(contactUserInApp.speciality),
                          trailing: contactUserInApp.alreadyInGroup?Text('Already in group'):Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xFF5A227E),
                            value: contactUserInApp.selected,
                            shape: CircleBorder(),
                            onChanged: (bool? value) {
                              setState(() {
                                if (filter) {
                                  for (int i = 0;
                                  i <
                                      _controller
                                          .chatGroupContact.value.length;
                                  i++) {
                                    if (_controller
                                        .chatGroupContact.value[i].userId ==
                                        contactUserInApp.userId) {
                                      _controller
                                          .updateSelectedUserFromContact(i);
                                    }
                                  }
                                } else {
                                  _controller
                                      .updateSelectedUserFromContact(index);
                                }
                              });
                            },
                          ),
                        );
                      },
                      itemCount: filter
                          ? filterContactUserInAppList.length
                          : _controller.chatGroupContact.value.length,
                    ),
                  );
                }
              }),
            ],
          ),
        ]),
      ),
    );
  }
}
