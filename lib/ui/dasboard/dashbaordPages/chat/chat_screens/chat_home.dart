import 'package:doc_talk/controller/chat_controller.dart';
import 'package:doc_talk/models/chat_group_message.dart';
import 'package:doc_talk/models/chat_group_modal.dart';
import 'package:doc_talk/networks/api_client.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/chat/chat_screens/patient_list_active.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/chat/chat_settings/chat_setting.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/widgets/bottom_modal.dart';
import 'package:doc_talk/ui/dasboard/dashboard_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../controller/dashboard_data_controller.dart';
import '../../../../../networks/api_constants.dart';
import '../../../../../widgets/doc_talk_button.dart';
import '../../../patient/patient.dart';
import '../../profile/profile.dart';
import '../../profile/widgets/buttom_icon_bottom.dart';
import 'chat_tile.dart';

class ChatHomeScreen extends StatefulWidget {
  ChatGroupModel chatGroupModel;
  bool creatingFromContacts;

  ChatHomeScreen(
      {required this.chatGroupModel, this.creatingFromContacts = false});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  late IO.Socket socket;

  final DashboardDataController _controller =
      Get.put(DashboardDataController());
  TextEditingController _textController = new TextEditingController();

  late ScrollController _scrollController = new ScrollController();

  int _currentPageCount = 0;
  //int _currentPageNext = 0;
  List<ChatGroupMessage> chatMessageList = [];

  late String sendMessageValueFromText;

  var onLineUser = [];

  bool _chatLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    initializeChatScreenData();
    super.initState();
  }

  initializeChatScreenData() async {
    joinSocket();
    await fetchChatData();
    _scrollController.addListener(_scrollListener);

    if (widget.creatingFromContacts) {
      sendMessageUserAdded();
    }

    List<ChatGroupUserTotal> groupTotalGroupMemebers = await ApiClient()
        .getTotalGroupMembersFromGroup(
            groupId: widget.chatGroupModel.chatGroupId,
            accessToken: _controller.dashboardDataModal.value.accessToken!);

    _controller.updateTotalUserInChatGroup(groupTotalGroupMemebers);
    _controller.updateOnlineStatusOfGroups(onLineUser);
  }

  sendMessageUserAdded() {
    for (int i = 0; i < _controller.chatGroupContact.length; i++) {
      if (_controller.chatGroupContact[i].selected) {
        sendMessage(
            messageType: "text",
            bot: true,
            message:
                '${_controller.dashboardDataModal.value.fullName} added ${_controller.chatGroupContact[i].fullName}');
      }
    }
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent ||
        !_scrollController.position.outOfRange) {
      fetchChatData();
    }
  }

  sendMessage(
      {required String messageType,
      required String message,
      bool bot = false}) {
    Map<String, dynamic> map = {
      "messageType": messageType,
      "roomName": widget.chatGroupModel.chatGroupName,
      "room": widget.chatGroupModel.chatGroupId,
      "messageValue": message,
      "email": bot ? "bot" : _controller.dashboardDataModal.value.contactNumber,
      "name": bot ? "bot" : _controller.dashboardDataModal.value.fullName,
      "userImg": bot ? "bot" : _controller.dashboardDataModal.value.image,
    };
    socket.emit("chatMessage", map);
  }

  joinSocket() {
    Map joinChatGroup = {
      "username": _controller.dashboardDataModal.value.contactNumber,
      "room": widget.chatGroupModel.chatGroupId
    };

    socket = IO.io(SOCKET_URL, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.connect();

    // print(socket.);
    print(socket.connected);

    socket.on("connect", (_) {
      print(socket.connected);
      print('connected');
      socket.emit('joinRoom', joinChatGroup);

      socket.on('event', (data) => print(data));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));

      socket.on("roomUsers", (data) {
        var users = data["users"];
        setState(() {
          onLineUser = users;
        });
      });

      socket.on("message", (data) {
        if (data.containsKey("messageValue") && data.containsKey("sender")) {
          ChatGroupMessage chatMessage = ChatGroupMessage(
            messageValue: data["messageValue"],
            messageType: data["messageType"],
            senderEmail: data["sender"]["email"],
            senderName: data["sender"]["name"],
            senderImg: data["sender"]["userImg"],
            timeStamp: data["timestamp"],
          );

          setState(() {
            chatMessageList.insert(0, chatMessage);
          });
        }
      });
    });
  }

  fetchChatData() async {
    setState(() {
      _chatLoading = true;
    });
    _currentPageCount++;

    List<ChatGroupMessage> newChatGroupMessage = await ApiClient()
        .getMessagesOfGroup(
            accessToken: _controller.dashboardDataModal.value.accessToken!,
            groupId: widget.chatGroupModel.chatGroupId,
            pageNumber: _currentPageCount);

    for (ChatGroupMessage chatGroupMessage in newChatGroupMessage) {
      chatMessageList.add(chatGroupMessage);
    }

    setState(() {
      _chatLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Theme.of(context).primaryColor,
              bottomOpacity: 0.0,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: onBackPress,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    widget.chatGroupModel.chatGroupName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Obx(() {
                    return Text(
                      '${_controller.getTotalOnline()}/${_controller.totalUserInGroups.length} online',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFCCCCCC),
                      ),
                    );
                  }),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      if (_controller.getTotalOnline() > 0 &&
                          _controller.totalUserInGroups.length > 0) {
                        await Get.to(ChatSettings(
                          chatGroupId: widget.chatGroupModel.chatGroupId,
                          chatGroupName: widget.chatGroupModel.chatGroupName,
                        ))?.then((value) async {
                          await initializeChatScreenData();

                          if (_controller.chatSettingBackMessage.value ==
                              BackMessageTypeChat.USER_ADDED) {
                            sendMessageUserAdded();
                          }

                          if (_controller.chatSettingBackMessage.value ==
                              BackMessageTypeChat.GROUP_LEAVE) {
                            await ApiClient().leaveGroup(
                                accessToken: _controller
                                    .dashboardDataModal.value.accessToken,
                                groupId: widget.chatGroupModel.chatGroupId,
                                contactNumber: _controller
                                    .dashboardDataModal.value.contactNumber);
                            sendMessage(
                                messageType: "text",
                                message:
                                    "${_controller.dashboardDataModal.value.fullName} left the group",
                                bot: true);
                            Get.offAll(DashboardHomeScreen());
                          }
                        });
                      }
                    },
                    icon: Icon(Icons.info)),
              ],
            ),
            body: Stack(children: [
              Positioned(
                child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 70,
                            height: 70,
                            child: DocTalkButton(
                              btnTitle: "+",
                              onPressed: ()  async {
                                Get.to(PatientAdd(
                                  roomId: widget.chatGroupModel.chatGroupId,
                                ))?.then((value) {
                                  if(socket==null){
                                    joinSocket();

                                  }
                                  //sendMessage(messageType: "bot", message: "message");






                                });
                              },
                            )),

                        Container(
                          height: 115,
                            width: MediaQuery.of(context).size.width-80,
                            child: ChatGroupActivePatientList(chatGroupId: widget.chatGroupModel.chatGroupId,)),


                      ],
                    )),
                top: 0,
                left: 0,
                right: 0,
              ),
              Positioned(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  controller: _scrollController,
                                  reverse: true,
                                  itemCount: chatMessageList.length,
                                  itemBuilder: (context, position) {
                                    bool isMe = false;
                                    bool isBot = false;
                                    if (_controller.dashboardDataModal.value
                                            .contactNumber ==
                                        chatMessageList[position].senderEmail) {
                                      isMe = true;
                                    }
                                    if (chatMessageList[position]
                                            .senderEmail
                                            .toLowerCase() ==
                                        "bot") {
                                      isBot = true;
                                    }
                                    return MessageTile(
                                      senderImage:
                                          chatMessageList[position].senderImg,
                                      senderName:
                                          chatMessageList[position].senderName,
                                      messageType:
                                          chatMessageList[position].messageType,
                                      timeStamp:
                                          chatMessageList[position].timeStamp,
                                      isBot: isBot,
                                      messageValue: chatMessageList[position]
                                          .messageValue,
                                      isMe: isMe,
                                    );
                                  },
                                ),
                              ),
                              Visibility(
                                visible: _chatLoading,
                                child: Positioned(
                                  top: 2,
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                      strokeWidth: 0.4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 7),
                          child: SafeArea(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _textController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    autocorrect: false,
                                    textCapitalization: TextCapitalization.none,
                                    onChanged: (value) {
                                      sendMessageValueFromText = value;

                                      if (value.startsWith('@')) {
                                        //for future updates
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      fillColor: Color(0xFFE5E5E5),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            width: 0.8, color: Colors.black12),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            width: 0.8, color: Colors.black12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            width: 0.8, color: Colors.black12),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      hintText: "Type your message here...",
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    bottomModal(
                                        height: 150,
                                        context: context,
                                        child: StatefulBuilder(
                                          builder: (context, setState) {
                                            return Container(
                                              height: 150,
                                              child: Column(
                                                children: <Widget>[
                                                  BottomIconButton(
                                                    onPressed: () async {
                                                      await uploadPicInChat(
                                                          IMAGESOURCE.CAMERA);
                                                    },
                                                    icon: Icons.photo_camera,
                                                    title:
                                                        'Take photo from Camera',
                                                  ),
                                                  BottomIconButton(
                                                    onPressed: () async {
                                                      await uploadPicInChat(
                                                          IMAGESOURCE.GALLERY);
                                                    },
                                                    icon: Icons.photo,
                                                    title:
                                                        'Take photo from Image Gallery',
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ));
                                  },
                                  icon: Icon(Icons.attachment),
                                  color: Theme.of(context).primaryColor,
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (sendMessageValueFromText != null) {
                                        if (sendMessageValueFromText.length >
                                            0) {
                                          sendMessage(
                                              messageType: "text",
                                              message:
                                                  sendMessageValueFromText);
                                          _textController.clear();
                                        }
                                      }
                                    },
                                    color: Theme.of(context).primaryColor,
                                    icon: const Icon(Icons.send))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                top: MediaQuery.of(context).size.height * 0.15,
                left: 0,
                right: 0,
                bottom: 0,
              ),
            ])),
      ),
    );
  }

  Future<void> uploadPicInChat(IMAGESOURCE imageSource) async {
    Navigator.pop(context);
    final ImagePicker _picker = ImagePicker();
    XFile? image;
    imageSource == IMAGESOURCE.CAMERA
        ? image = await _picker.pickImage(source: ImageSource.camera)
        : image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (image != null && image != "") {
        String imageUrl = await ApiClient().getImagePathForChat(
            accessToken: _controller.dashboardDataModal.value.accessToken!,
            image: image);
        if (imageUrl != '') {
          sendMessage(messageType: "img", message: imageUrl);
        }
      }
    }
  }

  Future<bool> onBackPress() async {
    socket.dispose();
    _controller.resetChatData();
    Navigator.of(context).pop();
    return true;
  }

  // @override
  // void deactivate() {
  //   socket.dispose();
  //   super.deactivate();
  // }
  //
  // @override
  // void dispose() {
  //   socket.dispose();
  //   super.dispose();
  // }

}
