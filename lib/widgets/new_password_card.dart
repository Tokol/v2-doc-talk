import 'package:doc_talk/networks/api_client.dart';
import 'package:doc_talk/ui/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/foreget_password_controller.dart';

class NewPasswordCard extends StatefulWidget {
  const NewPasswordCard({Key? key}) : super(key: key);

  @override
  State<NewPasswordCard> createState() => _NewPasswordCardState();
}

class _NewPasswordCardState extends State<NewPasswordCard> {
  final ForgetPasswordController _controller = Get.put(ForgetPasswordController());


  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNewobsecureText = false;
  bool _isConfirmobsecureText = false;


  RequestPasswordChange requestPasswordChange = RequestPasswordChange();
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
        height: deviceSize.height * 0.40,
        width: deviceSize.width * 0.8,
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("New Password",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900])),
                const SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value){
                    requestPasswordChange.otp=value;
                  },
                  controller: _otpController,
                  decoration: InputDecoration(
                    hintText: "Enter 4 digits OTP code here",
                    labelStyle: TextStyle(
                      color: Colors.indigo[900],
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter 4 digits OTP code";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value){
                    requestPasswordChange.newPass=value;
                  },
                  controller: _newpasswordController,
                  decoration: InputDecoration(
                    hintText: "Enter your new password here",
                    labelStyle: TextStyle(
                      color: Colors.indigo[900],
                    ),
                    suffixIcon: _isNewobsecureText
                        ? IconButton(
                      icon: const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isNewobsecureText = !_isNewobsecureText;
                        });
                      },
                    )
                        : IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isNewobsecureText = !_isNewobsecureText;
                        });
                      },
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  obscureText: _isNewobsecureText,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Please enter atleast 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value){
                    requestPasswordChange.confirmPass=value;
                  },
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: "Enter your new password again",
                    labelStyle: TextStyle(
                      color: Colors.indigo[900],
                    ),
                    suffixIcon: _isConfirmobsecureText
                        ? IconButton(
                      icon: const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isConfirmobsecureText =
                          !_isConfirmobsecureText;
                        });
                      },
                    )
                        : IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isConfirmobsecureText =
                          !_isConfirmobsecureText;
                        });
                      },
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  obscureText: _isConfirmobsecureText,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (_newpasswordController.text !=
                        _confirmPasswordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                    Size(MediaQuery.of(context).size.width * 0.8, 50),
                    primary: const Color.fromRGBO(105, 49, 142, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {

                    if(requestPasswordChange.otp.length<4 ){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid Otp Check your otp again'),
                        ),
                      );
                    }

                   else if(requestPasswordChange.newPass.length<6 || requestPasswordChange.confirmPass.length<6){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password length must be more than 6 characters'),
                        ),
                      );
                    }


                   else if(requestPasswordChange.newPass!=requestPasswordChange.confirmPass){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('New password and confirm Password Not matched!'),
                        ),
                      );
                    }



                 else {
                      var response = await ApiClient().changePasswordFromPhoneRequest(id: _controller.userId.value, newPass:requestPasswordChange.newPass,
                        confirmPass:requestPasswordChange.confirmPass, otp: requestPasswordChange.otp,
                      );

                      print(response);

                      try {

                       if( response['msg'] =="Password Changed !"){
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text('Password Changed!! '),
                           ),
                         );
                         Get.to(() =>  SplashScreen());
                       }

                       else {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text('Wrong OTP sent!! '),
                           ),
                         );
                       }

                      }

                      catch(e){

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Wrong OTP sent!! '),
                          ),
                        );
                      }
                    }




                  },
                  child: const Text("Change Password",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            )),
      ),
    );
  }
}

class RequestPasswordChange {
   String otp="";
   String newPass="";
   String confirmPass="";
}