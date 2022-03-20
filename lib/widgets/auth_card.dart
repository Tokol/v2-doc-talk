// ignore_for_file: prefer_const_constructors

import 'package:doc_talk/models/login_model.dart';
import 'package:doc_talk/models/register.dart';
import 'package:doc_talk/networks/api_client.dart';

import 'package:doc_talk/ui/auth/otp_verification.dart';
import 'package:doc_talk/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../models/resend_otp.dart';
import '../ui/dasboard/dashboard_route.dart';
import 'verfication_card.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isObscurec = true;
  AuthMode _authMode = AuthMode.login;

  final _specialityfNode = FocusNode();
  final _dropdownfNode = FocusNode();
  final _mobilefNode = FocusNode();
  final _passwordfNode = FocusNode();
  final _confirmPasswordfNode = FocusNode();

  // Initial Selected Value
  String dropdownvalue = 'Consultant';
  int labled = 0;
  late String accessToken;

  final ApiClient _apiClient = ApiClient();
  final RegisterRequestModel _registerRequestModel = RegisterRequestModel();
  final LoginRequestModel _loginRequestModel = LoginRequestModel();
  final ResendOtpRequestModel _resendOtpRequestModel = ResendOtpRequestModel();

  late String deviceID;
  late String userId;
  // List of items in our dropdown menu
  var items = [
    'Consultant',
    'Resident',
    'Medical Officer',
    'Nurse',
  ];
  Future<void> loginFunc() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.red.shade300,
      ));

      print(_loginRequestModel.toJson());
      _apiClient.login(_loginRequestModel).then((value) {
        userId = value.user.toString();
        deviceID = "12345";

        if(value.user=="invalid"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${value.msg}'),
            backgroundColor: Colors.red.shade300,
          ));

        }


        else {
          if (value.isNumberVerified == true) {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardRoute(

                    )));
          }
          if (value.isNumberVerified == false) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: ${value.msg}'),
              backgroundColor: Colors.red.shade300,
            ));
            _resendOtpRequestModel.contactNumber = _loginRequestModel.email;
            print(_resendOtpRequestModel.toJson());

            _apiClient.resendOtpApi(_resendOtpRequestModel).then((value) {
              if (value.isOtpSent == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpandForgetPassword(
                          cardmode: Cardmode.otpVerify,
                          deviceID: deviceID,
                          userId: userId,
                        )));
              }
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: ${value.msg}'),
              backgroundColor: Colors.red.shade300,
            ));
          }
        }


      });
    }
  }

  Future<void> registerFunc() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      print('requestModal');
      print(_registerRequestModel.toJson());
      _apiClient.register(_registerRequestModel).then((value) {
        if (value.isOtpSent == true) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${value.msg}'),
            backgroundColor: Colors.green.shade300,
          ));
          deviceID = _registerRequestModel.deviceId.toString();
          userId = value.userId.toString();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpandForgetPassword(
                        cardmode: Cardmode.otpVerify,
                        deviceID: deviceID,
                        userId: userId,
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${value.msg}'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      });
    }
  }

  DateTime selectedDate = DateTime.now();
  String value = "";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8.0,
      child: Container(
        width: deviceSize.width * 0.75,
        height: deviceSize.height * 0.65,
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.4)),
                    ),
                    child: ToggleSwitch(
                      minHeight: 38,
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      cornerRadius: 20.0,
                      activeBgColors: const [
                        [Color.fromRGBO(105, 49, 142, 1)],
                        [Color.fromRGBO(105, 49, 142, 1)],
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.black,
                      initialLabelIndex: labled,
                      totalSwitches: 2,
                      labels: const ['Login', 'Sign Up'],
                      radiusStyle: true,
                      onToggle: (v) {
                        setState(() {
                          _authMode = _authMode == AuthMode.login
                              ? AuthMode.signup
                              : AuthMode.login;
                        });
                        if (v == 0) {
                          labled = 0;
                          _authMode = AuthMode.login;
                        }
                        if (v == 1) {
                          labled = 1;
                          _authMode = AuthMode.signup;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: (newValue) =>
                        _registerRequestModel.name = newValue,
                    enabled: _authMode == AuthMode.signup,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name!';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_dropdownfNode);
                    },
                  ),
                if (_authMode == AuthMode.signup)
                  CustomDropDownwithText(
                    value: dropdownvalue,
                    items: items,
                    focusNode: _dropdownfNode,
                    onChanged: (String? newValue) {
                      dropdownvalue = newValue!;
                      _registerRequestModel.userType = dropdownvalue;
                      _registerRequestModel.qualification = dropdownvalue;
                    },
                  ),
                if (_authMode == AuthMode.signup)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Speciality",
                          style: TextStyle(
                              color: Color.fromRGBO(105, 49, 142, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (newValue) =>
                              _registerRequestModel.speciality = newValue,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: "(e.g:General Physician)",
                          ),
                          focusNode: _specialityfNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_mobilefNode);
                          },
                        ),
                      ),
                    ],
                  ),
                if (_authMode == AuthMode.signup)

                  TextFormField(
                      readOnly: true,
                      onChanged: (newValue) =>
                          _registerRequestModel.dob = value,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: value!=""?value:"Date of Birth",
                        hintText:  value!=""?value:"Date of Birth",
                      ),
                      onTap: () async {
                        final DateTime? selected = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(1840),
                          lastDate: DateTime.now()
                        );
                        if (selected != null && selected != selectedDate) {
                          setState(() {
                            selectedDate = selected;
                            value =
                                "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                          });
                        }
                      }),
                if (_authMode == AuthMode.login) const SizedBox(height: 30.0),
                if (_authMode == AuthMode.login)
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: (newValue) {
                      _loginRequestModel.email = newValue;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Mobile Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value.length != 10) {
                        return 'Invalid Number!';
                      }
                      return null;
                    },
                    focusNode: _mobilefNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordfNode);
                    },
                  ),
                if (_authMode == AuthMode.signup)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (newValue) =>
                              _registerRequestModel.email = newValue,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            onChanged: (newValue) =>
                                _registerRequestModel.contact_number = newValue,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Mobile Number',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_authMode == AuthMode.login) const SizedBox(height: 25.0),
                TextFormField(
                  textInputAction: _authMode == AuthMode.signup
                      ? TextInputAction.next
                      : TextInputAction.done,
                  onChanged: (newValue) {
                    _registerRequestModel.password = newValue;
                    _loginRequestModel.password = newValue;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: const Color.fromRGBO(105, 49, 142, 1),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )),
                  obscureText: _isObscure,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  focusNode: _passwordfNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_confirmPasswordfNode);
                  },
                ),
                if (_authMode == AuthMode.login) const SizedBox(height: 30.0),
                if (_authMode == AuthMode.login)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forget password?',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TextButton(
                        child: const Text(
                          'Click here',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(105, 49, 142, 1)),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OtpandForgetPassword(
                          //               cardmode: Cardmode.forgetPassword,
                          //             )));
                        },
                      ),
                    ],
                  ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscurec
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromRGBO(105, 49, 142, 1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscurec = !_isObscurec;
                            });
                          },
                        )),
                    obscureText: _isObscurec,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 45),
                    primary: const Color.fromRGBO(105, 49, 142, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    _authMode == AuthMode.signup ? registerFunc() : loginFunc();
                  },
                  child: Text(
                    _authMode == AuthMode.login ? 'Login' : 'Sign Up',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
