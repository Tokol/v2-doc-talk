import 'package:doc_talk/ui/auth/auth_screen.dart';
import 'package:doc_talk/widgets/new_password_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: AuthScreenBody(
            context: context, customWidget: const NewPasswordCard()));
  }
}
