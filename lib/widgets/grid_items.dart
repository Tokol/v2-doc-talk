import 'package:flutter/material.dart';

import '../helper/utils.dart';

class GridviewItem extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPress;
  final String name;
  const GridviewItem( {required this.imageUrl, required this.onPress, required this.name});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        width: 20,
        child: AvatarImage(
          imageUrl: imageUrl,
          onPress: onPress,
          name: name,

        ));
  }
}

class AvatarImage extends StatelessWidget {
  const AvatarImage({Key? key, required this.imageUrl,required this.onPress, required this.name}) : super(key: key);
  final String imageUrl;
  final String name;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, fit: StackFit.expand, children: [
      imageUrl=="null"?
      CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child:Text(
          Utils.getShortCutOfString(longValue:name),
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        ),):  CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      Positioned(
          top: -1,
          right: 1,
          child: GestureDetector(
            onTap:onPress,
            child: Container(
              height: 20,
              width: 20,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.white),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          )),
    ]);
  }
}