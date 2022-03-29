class ChatGroupMessage {
  String messageType;
  String messageValue;
  String senderEmail;
  String senderName;
  String senderImg;
  int timeStamp;
  ChatGroupMessage({required this.messageType, required this.messageValue,
    required this.senderEmail,required this.senderName, required this.senderImg,
    required this.timeStamp
  });

}

/*emiit ko lagi
* "messageType": "text",
                                        "roomName":widget.chatGroup.groupName,
                                        "room": widget.chatGroup.groupId,
                                        "messageValue": sendMessageValue,
                                        "email": user.email,
                                        "name": user.fullName,
                                        "userImg": user.img,
* */