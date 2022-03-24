import 'package:flutter/material.dart';

bottomModal({required double height, required BuildContext context, required Widget child}) {
  return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: height,
          child: SingleChildScrollView(child: child),
        );
      });
}
