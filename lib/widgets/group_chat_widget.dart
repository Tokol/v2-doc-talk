//
// import 'package:flutter/material.dart';
// import 'package:doc_talk/models/otp_verification.dart';
//
//
// class GroupChatScreen extends StatelessWidget {
//   const GroupChatScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     User users = User();
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         bottomOpacity: 0.0,
//         elevation: 0.0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//             size: 25,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           // ignore: prefer_const_literals_to_create_immutables
//           children: [
//             Text(
//               "Health Care Hospital",
//               style: TextStyle(fontSize: 18.0),
//             ),
//             Text(
//               "4 Participants",
//               style: TextStyle(
//                 fontSize: 14.0,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 15),
//         child:
//             Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(
//                   Icons.add,
//                   color: Theme.of(context).primaryColor,
//                   size: 25,
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 width: 280,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white),
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         Icon(
//                           Icons.bed,
//                         ),
//                         Text("Bed: 111/22"),
//                         Text("Ward: Pysc"),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.verified_user_outlined),
//                             Text("Simran"),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.calendar_month),
//                             Text("November 4, 2022"),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Expanded(
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.3,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 children: [],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   // _appbar(BuildContext context, User users) {
//   //   return Padding(
//   //     padding: const EdgeInsets.all(8.0),
//   //     child: Column(
//   //       children: [
//   //         Row(
//   //           children: [
//   //             Icon(
//   //               Icons.arrow_back,
//   //               color: Colors.white,
//   //               size: 30,
//   //             ),
//   //             Column(
//   //               children: const [
//   //                 Text(
//   //                   "Health Care Hospital",
//   //                   style: TextStyle(color: Colors.white),
//   //                 ),
//   //                 Text(
//   //                   "4 Participants",
//   //                   style: TextStyle(color: Colors.grey),
//   //                 ),
//   //               ],
//   //             ),
//   //           ],
//   //         ),
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //           children: [
//   //             CircleAvatar(
//   //               backgroundColor: Colors.white,
//   //               child: Icon(
//   //                 Icons.add,
//   //                 color: Colors.purple,
//   //               ),
//   //             ),
//   //             Container(
//   //               height: 100,
//   //               width: 300,
//   //               decoration: BoxDecoration(
//   //                   borderRadius: BorderRadius.circular(10),
//   //                   color: Colors.white),
//   //             )
//   //           ],
//   //         )
//   //       ],
//   //     ),
//   //   );
// }