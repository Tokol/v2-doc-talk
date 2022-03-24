
import 'package:doc_talk/networks/api_client.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/widgets/actionbutton.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  final String accessToken;
  ChangePassword({required this.accessToken});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _currentPasswordController = TextEditingController();

  TextEditingController _newPasswordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isCurrentObscure = true;

  bool _isNewObscure = true;

  bool _isConfirmObsure = true;

  bool requestChange = false;


  UpdatePasswordModal updatePasswordModal = UpdatePasswordModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffebf2fa),
      appBar: AppBar(
        backgroundColor: const Color(0xffebf2fa),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  onChanged: (value){
                    updatePasswordModal.currentPassword = value;
                  },
                  controller: _currentPasswordController,
                  obscureText: _isCurrentObscure,
                  decoration: InputDecoration(
                    labelText: "Current Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isCurrentObscure = !_isCurrentObscure;
                          });
                        },
                        icon: Icon(
                          _isCurrentObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _newPasswordController,
                  obscureText: _isNewObscure,
                  onChanged: (value){
                    updatePasswordModal.newPassword = value;
                  },
                  decoration: InputDecoration(

                    labelText: "New Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isNewObscure = !_isNewObscure;
                          });
                        },
                        icon: Icon(
                          _isNewObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _isConfirmObsure,
                  onChanged: (value){
                    updatePasswordModal.confirmNewPassword = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isConfirmObsure = !_isConfirmObsure;
                          });
                        },
                        icon: Icon(
                          _isConfirmObsure
                              ? Icons.visibility
                              : Icons.visibility_off,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (_) {
                    if (_newPasswordController.text !=
                        _confirmPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),

             requestChange? SizedBox():
              SizedBox(
                  width: 300,
                  child: ActionButton(
                    buttonText: 'Change Password',
                    onPressed: () async {

                      if(updatePasswordModal.validate()){

                        Map<String, dynamic> map = {
                          "oldPassword":updatePasswordModal.currentPassword,
                          "newPassword":updatePasswordModal.newPassword,
                          "confirmPassword":updatePasswordModal.confirmNewPassword,
                        };

                        setState(() {
                          requestChange = true;
                        });

                    await ApiClient().changePassword(map: map, accessToken: widget.accessToken);

                        setState(() {
                          requestChange = false;
                        });

                      }

                      else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Validation error!! please check all the fields!'),
                          backgroundColor: Colors.red.shade300,
                        ));
                      }


                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}


class UpdatePasswordModal {
   String currentPassword = '';
   String newPassword = "";
   String confirmNewPassword ="";



  bool validate(){

    print(currentPassword);
    print(newPassword);
    print(confirmNewPassword);

    if(currentPassword==""){
      return false;
    }
    if(newPassword.length>6 && confirmNewPassword.length>6){
      if(newPassword==confirmNewPassword){
        return true;
      }
    }
    return false;
  }


}
