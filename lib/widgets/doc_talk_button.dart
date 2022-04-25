import 'package:flutter/material.dart';

class DocTalkButton extends StatelessWidget {
  final String btnTitle;
  final Function() onPressed;

  DocTalkButton({this.btnTitle="", required this.onPressed});
  @override
  Widget build(BuildContext context) {

    return ElevatedButton(

      onPressed: onPressed,
      child: Text(btnTitle, style: TextStyle(color: Theme.of(context).primaryColor, fontSize:  40,),
      textAlign: TextAlign.center,
      ),

      style: ElevatedButton.styleFrom(
        elevation: 15,
        shape: StadiumBorder(),
        primary: Colors.white,

      ),
    );

  }
  //   return ElevatedButton(
  //     style: ButtonStyle(
  //       shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(30.0)
  //       ),
  //     ),
  //
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(30.0)),
  //     ),
  //     highlightColor: Colors.redAccent,
  //     color: Theme.of(context).primaryColor,
  //     splashColor: Colors.green,
  //     onPressed: onPressed,
  //     elevation: 10.0,
  //     child: Container(
  //         padding: EdgeInsets.all(10.0),
  //         height: 60,
  //         width: MediaQuery.of(context).size.width - 80,
  //         child: Center(
  //             child: Text(
  //               btnTitle,
  //               style: TextStyle(color: Colors.white, fontSize: 18.0),
  //             ))),
  //   );
  // }
}