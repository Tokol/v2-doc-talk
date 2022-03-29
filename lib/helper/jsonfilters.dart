import '../models/chat_group_message.dart';
import '../models/chat_group_modal.dart';

class JsonFilters {

  List<ChatGroupModel> getChatGroups(dynamic data){
    List<ChatGroupModel> chatGroupModel = [];

    if(data.length>0){
      for(int i=0; i<data.length; i++) {

        List<dynamic> users = data[i]["users"];
        String chatGroupId = data[i]["_id"];
        String chatGroupName = data[i]["group_name"];
        String admin = data[i]["admin"];
        String lastMessageType = data[i]["lastMessageValue"]["messageType"];
        String lastMessageValue = data[i]["lastMessageValue"]["messageValue"];
        String lastMessageSenderImage = data[i]["lastMessageValue"]["sender"]["userImg"];
        String lastMessageSenderContact = data[i]["lastMessageValue"]["sender"]["email"];
        String lastMessageSenderName = data[i]["lastMessageValue"]["sender"]["name"];
        int lastMessageTimeStamp = data[i]["lastMessageValue"]["timestamp"];

        chatGroupModel.add(ChatGroupModel(
            users: users,
            chatGroupId: chatGroupId,
            chatGroupName:chatGroupName,
            admin: admin,
            lastMessageType: lastMessageType,
            lastMessageValue: lastMessageValue,
            lastMessageSenderImage: lastMessageSenderImage,
            lastMessageSenderContact: lastMessageSenderContact,
            lastMessageSenderName:  lastMessageSenderName,
            lastMessageTimeStamp: lastMessageTimeStamp
        )
        );
      }



    }


    return chatGroupModel;
  }


  List<ChatGroupMessage>  getChatMessageFromGroups(dynamic data){
    List<ChatGroupMessage> chatMessageFromGroups = [];

    for(int i=0; i<data.length;i++){

      String messageType = data[i]["messageType"];
      String messageValue = data[i]["messageValue"];
      String senderEmail = data[i]["sender"]["email"];
      String senderName = data[i]["sender"]["name"];
      String senderImg = data[i]["sender"]["userImg"];
      int timeStamp = data[i]["timestamp"];
      chatMessageFromGroups.add(ChatGroupMessage(messageType: messageType,
          messageValue: messageValue, senderEmail: senderEmail,
          senderName: senderName, senderImg: senderImg,
          timeStamp: timeStamp));

    }

    return chatMessageFromGroups;
  }

  ChatGroupModel getChatGroupModelFromCreateGroup(dynamic response,{required String contactNumber, required String groupName}){
    var data = response["data"]["messages"][0];

    String messageType = data["messageType"];

    String messageValue = data["messageValue"];

    String senderEmail = data["sender"]["email"];

    String senderName =  data["sender"]["name"];

    String senderImg =  data["sender"]["userImg"];


    String groupId = response["data"]["_id"];


    int timeStamp =  data["timestamp"];





    ChatGroupModel chatGroupModel = ChatGroupModel(chatGroupId:groupId, chatGroupName: groupName,
        admin: contactNumber, lastMessageType: messageType,
        lastMessageValue: messageValue, lastMessageSenderImage: senderImg,
        lastMessageSenderContact: senderEmail, lastMessageSenderName: senderName, lastMessageTimeStamp: timeStamp);


    return chatGroupModel;
  }



}