import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../helper/utils.dart';

class MessageTile extends StatelessWidget {
  final String messageValue;
  final String messageType;
  final bool isMe;
  final bool isBot;
  final String senderName;
  final String senderImage;
  final int timeStamp;
  const MessageTile(
      {Key? key,
      required this.senderName,
      required this.senderImage,
      required this.timeStamp,
      required this.messageValue,
      required this.isMe,
      required this.messageType,
      this.isBot = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isBot) {
      return botMessage(context);
    } else if (isMe) {
      return myMessage(context);
    } else {
      return otherMessage(context);
    }
  }

  Widget otherMessage(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5, right: 2),
            child: getAvatar(Theme.of(context).primaryColor)),
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(35.0),
                    ),
                    elevation: 5.0,
                    color: Colors.grey[200],
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            senderName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          textOrImage(context, messageType, Colors.black),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        getTime(timeStamp),
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 10.0),
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget myMessage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: Theme.of(context).primaryColor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: textOrImage(context, messageType, Colors.white)),
          ),
          Text(
            getTime(timeStamp),
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget botMessage(BuildContext context) {
    return Column(
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            margin: EdgeInsets.only(top: 25,left: 2, right: 2),
            child: CircleAvatar(radius: 20,
              backgroundImage: AssetImage('assets/images/xyba_bot.png'),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10.0, right: 10,bottom: 10),

            child: Material(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(35.0),
              ),
              elevation: 10,
              child: Column(

                children: [

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(

                        topRight: Radius.circular(40.0),

                      ),
                    ),

                    width: MediaQuery.of(context).size.width/2,

                    child:  Padding(
                        padding: EdgeInsets.all(5.0),

                        child: Text('DOC TALK BOT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                  ),
                  Container(width: MediaQuery.of(context).size.width/2,

                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: textOrImage(context, messageType, Colors.black),
                  ),



)
                ],
              ),
            ),
          ),

        ],
      ),
      Text(getTime(timeStamp),textAlign: TextAlign.start, style: TextStyle(fontSize: 11, color: Colors.black87),)
    ],);
  }

  String getTime(int timeStamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    String time = DateFormat.jms().format(dt);
    String monthDay = DateFormat.MMMMd().format(dt);
    String year = DateFormat.y().format(dt);

    return '$time, $monthDay, $year';
  }

  Widget textOrImage(BuildContext context, String messageType, Color color) {
    if (messageType == 'text') {
      return SelectableLinkify(
        onOpen: (link) async {
          if (await canLaunch(link.url)) {
            await launch(link.url);
          } else {
            throw 'Could not launch $link';
          }
        },
        options: LinkifyOptions(humanize: false),
        linkStyle: TextStyle(color: Colors.blueAccent),
        style: color==Colors.black? Theme.of(context).textTheme.bodyText2:TextStyle(color: color),
        text: messageValue,
      );
    } else {
      return GestureDetector(
        onTap: () {
          showImageViewer(context, Image.network(messageValue).image);
        },
        child: Image(
          image: NetworkImage(messageValue),
        ),
      );
    }
  }

  Widget getAvatar(Color bgColor) {
    print(senderImage);
    if (senderImage.toString().toLowerCase() == 'null') {
      return CircleAvatar(
        backgroundColor: bgColor,
        radius: 20,
        child: Text(
          Utils.getShortCutOfString(longValue: senderName).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.0, color: Colors.white),
        ),
      );
    } else {
      return CircleAvatar(
          radius: 20,
          backgroundColor: bgColor,
          backgroundImage: NetworkImage(senderImage));
    }
  }
}
