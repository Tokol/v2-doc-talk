import 'package:doc_talk/helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatefulWidget {
  final String groupName;
  final String groupId;
  final String lastMessageText;
  String? imageUrl;
  final int time;
  final String messageBy;
  final String messageType;
  final VoidCallback onPress;

  MessageTile(
      {Key? key,
        required this.onPress,
      required this.groupName,
        required this.groupId,
      required this.lastMessageText,
      this.imageUrl,
      required this.time,
        required this.messageBy,
        required this.messageType,
      });

  @override
  _MessageTileState createState() => _MessageTileState();
}



class _MessageTileState extends State<MessageTile> {

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.fromMillisecondsSinceEpoch(widget.time);

    String time = DateFormat.jms().format(dt);
    String monthDay = DateFormat.MMMMd().format(dt);
    String year = DateFormat.y().format(dt);


    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: widget.imageUrl != null
                        ? Image.network(widget.imageUrl.toString())
                        : Text(Utils.getShortCutOfString(longValue: widget.groupName).toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontWeight:FontWeight.bold,fontSize: 14.0, color: Colors.white),),
                    maxRadius: 35,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.groupName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(children: [

                            Text(
                              Utils.getFirstWord(fullSentence: widget.messageBy)
                              , style: TextStyle(color:  Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                            Expanded(

                              child: Text(
                                Utils.dottedShortMessage(value: widget.lastMessageText, limit: 20),
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight:
                                    FontWeight.normal),
                              ),
                            ),

                          ],)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${time}\n${monthDay}\n${year}',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

/**DateTime.now().hour.toString() +
    ":" +
    DateTime.now().minute.toString(),**/