import 'package:doc_talk/helper/utils.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String groupName;
  final String lastMessageText;
  String? imageUrl;
  final String time;
  final String messageBy;

  MessageTile(
      {Key? key,
      required this.groupName,
      required this.lastMessageText,
      this.imageUrl,
      required this.time,
        required this.messageBy,
      });

  @override
  _MessageTileState createState() => _MessageTileState();
}



class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                                Utils.dottedShortMessage(value: widget.lastMessageText+" la lal la land is very sad movie at the end ...", limit: 15),
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
              widget.time,
              style: TextStyle(
                  fontSize: 12,
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