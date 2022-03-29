import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            color: const Color(0xFF5A227E),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}
