import 'package:flutter/material.dart';
import 'package:doc_talk/theme/app_theme.dart';

class CustomDropDownwithText extends StatelessWidget {
  CustomDropDownwithText(
      {Key? key,
      required this.value,
      required this.items,
      required this.focusNode,
      required this.onChanged})
      : super(key: key);

  String value;
  final List<String> items;
  final FocusNode focusNode;
  final Function(String? value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'I am a',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color.fromRGBO(105, 49, 142, 1),
            ),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField(
              hint: Text("(select user type)"),
              focusNode: focusNode,
              //value: widget.value,
              items: items.map((String item) {
                return DropdownMenuItem(
                  alignment: Alignment.centerLeft,
                  child: Text(item),
                  value: item,
                );
              }).toList(),
              onChanged: onChanged),
        ),
      ],
    );
  }
}
