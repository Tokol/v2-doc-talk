class ChatGroupModel {
  List<dynamic>? users;
  String chatGroupId;
  String chatGroupName;
  String admin;
  String lastMessageType;
  String lastMessageValue;
  String lastMessageSenderName;
  String lastMessageSenderImage;
  String lastMessageSenderContact;
  int lastMessageTimeStamp;

  ChatGroupModel(
      {  this.users,
      required this.chatGroupId,
      required this.chatGroupName,
      required this.admin,
      required this.lastMessageType,
      required this.lastMessageValue,
      required this.lastMessageSenderImage,
      required this.lastMessageSenderContact,
      required this.lastMessageSenderName,
      required this.lastMessageTimeStamp});

   Map<String, dynamic> toJson() {
    Map<String, dynamic> map;
    map = {
      "users": users,
      "chatGroupId": chatGroupId,
      "chatGroupName":chatGroupName,
      "admin":admin,
      "lastMessageType":lastMessageType,
      "lastMessageValue":lastMessageValue,
      "lastMessageSenderName":lastMessageSenderName,
      "lastMessageSenderImage":lastMessageSenderImage,
      "lastMessageSenderContact":lastMessageSenderContact,
      "lastMessageTimeStamp":lastMessageTimeStamp
    };

    return map;
  }
}
