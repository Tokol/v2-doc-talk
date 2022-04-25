import 'package:flutter/material.dart';

class RowListItem extends StatelessWidget {
  const RowListItem(
      {Key? key,
        required this.firstChild,
        required this.secondChild,
        required this.thirdChild,
        required this.isTitle})
      : super(key: key);

  final Widget firstChild;
  final Widget secondChild;

  final Widget thirdChild;
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: isTitle ? const Color(0xFF5A227E) : Colors.white,
                border: Border(
                    right: BorderSide(
                        color:
                        isTitle ? Colors.white : const Color(0xFF5A227E)),
                    bottom: BorderSide(
                        color:
                        isTitle ? Colors.white : const Color(0xFF5A227E))),
              ),
              child: Center(child: firstChild),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: isTitle ? const Color(0xFF5A227E) : Colors.white,
                border: Border(
                    right: BorderSide(
                        color:
                        isTitle ? Colors.white : const Color(0xFF5A227E)),
                    bottom: BorderSide(
                        color:
                        isTitle ? Colors.white : const Color(0xFF5A227E))),
              ),
              child: Center(child: secondChild),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: isTitle ? const Color(0xFF5A227E) : Colors.white,
                border: Border(
                    right: BorderSide(
                        color:
                        isTitle ? Colors.white : const Color(0xFF5A227E)),
                    bottom: BorderSide(
                        color:
                        isTitle ? Colors.white : const Color(0xFF5A227E))),
              ),
              child: Center(child: thirdChild),
            ),
          ),
        ],
      ),
    );
  }
}