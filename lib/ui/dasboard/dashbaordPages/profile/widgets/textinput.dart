import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key? key,
      required this.titleText,
      required this.hintText,
      required this.controller, required
      this.onchange})
      : super(key: key);

  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final Function(String)  onchange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w100, color: Colors.black),
        ),
        TextFormField(
          controller: controller,
          onChanged: onchange,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColor,

          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: const UnderlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
      ],
    );
  }
}

/*
*   Future<void> logout({String? accessToken}) async {
    Dio _dio = getApiClient();
    _dio.options.headers["x-access-token"] = accessToken;

    await _dio.put(USER_LOG_OUT);

    await PrefUtils.putString(ACCESS_TOKEN, '');
    await PrefUtils.putString(USER_ID, '');
    await PrefUtils.putString(USER_DETAIL, '');
    await PrefUtils.putString(DASHBOARD_VALUE, '');


}
* */