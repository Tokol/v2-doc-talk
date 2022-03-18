import 'package:doc_talk/ui/auth/auth_screen.dart';
import 'package:doc_talk/widgets/verfication_card.dart';
import 'package:flutter/material.dart';

class OtpandForgetPassword extends StatelessWidget {
  OtpandForgetPassword(
      {Key? key, required this.cardmode, this.deviceID, this.userId})
      : super(key: key);

  final Cardmode cardmode;
  String? deviceID;
  String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AuthScreen();
                }));
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: AuthScreenBody(
            context: context,
            customWidget: CustomCard(
              cardmode: cardmode,
              deviceId: deviceID,
              userId: userId,
            )));
  }
}
