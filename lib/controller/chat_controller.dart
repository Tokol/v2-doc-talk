import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/chat_group_message.dart';
import '../networks/api_constants.dart';

final currentPageCount = 0.obs;

final  chatMessageList = [].obs;
final chatRoomId = "".obs;
final userName = "".obs;

final loading = false.obs;


late IO.Socket socket;
void joinChat(){
  Map joinChatGroup = {
    "username": userName.value,
    "room": chatRoomId.value,
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
      print(users);
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
          chatMessageList.insert(0, chatMessage);
          chatMessageList.refresh();
      }
    });
  });

}


  disConnectSocket(){
    socket.dispose();
  }


// void sendMessage(
//     {required String messageType,
//       required String message,
//       bool bot = false}) {
//   Map<String, dynamic> map = {
//     "messageType": messageType,
//     "roomName": widget.chatGroupModel.chatGroupName,
//     "room": widget.chatGroupModel.chatGroupId,
//     "messageValue": message,
//     "email": bot ? "bot" : _controller.dashboardDataModal.value.contactNumber,
//     "name": bot ? "bot" : _controller.dashboardDataModal.value.fullName,
//     "userImg": bot ? "bot" : _controller.dashboardDataModal.value.image,
//   };
//   socket.emit("chatMessage", map);
// }

void resetChatRoom(){
  currentPageCount.update((val) {
    currentPageCount.value = 0;
    chatRoomId.value = "";
    userName.value="";
    chatMessageList.value=[];
  });


  //reset


}

