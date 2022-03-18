// ignore_for_file: prefer_const_constructors

import 'package:doc_talk/widgets/auth_card.dart';
import 'package:doc_talk/widgets/custom_clipper.dart';
import 'package:doc_talk/widgets/custom_toggle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AuthScreen extends StatelessWidget {
  static final String route = "/auth";

  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthScreenBody(
        context: context,
        customWidget: const AuthCard(),
      ),
    );
  }
}

class AuthScreenBody extends StatefulWidget {
  const AuthScreenBody({
    Key? key,
    required this.context,
    required this.customWidget,
  }) : super(key: key);

  final BuildContext context;
  final Widget customWidget;

  @override
  _AuthScreenBodyState createState() => _AuthScreenBodyState();
}

class _AuthScreenBodyState extends State<AuthScreenBody> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(0.5),
        // backgroundBlendMode: BlendMode.modulate,
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5), BlendMode.dstATop),
        ),
      ),
      child: Stack(children: [
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: 95,
              child: Image.asset('assets/images/xyba_logo.png')),
        ),
        Positioned(
          child: widget.customWidget,
          top: 160,
          right: 15,
          left: 15,
        ),
        Positioned(
            child: IconToggleButton(
              isSelected: isSelected,
              onPressed: () {
                setState(
                  () {
                    isSelected = !isSelected;
                  },
                );
              },
            ),
            left: 15,
            bottom: 8),
      ]),
    );
  }
}
