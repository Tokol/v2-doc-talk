import 'package:flutter/material.dart';

class BottomIconButton extends StatelessWidget {
  final IconData icon;
  final String title;

  final Function() onPressed;

  BottomIconButton({required this.icon, required this.onPressed,  required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(icon), onPressed: () {  },
          ),
          Text(title)
        ],
      ),
    );
  }
}