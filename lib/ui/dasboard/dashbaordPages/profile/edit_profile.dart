import 'dart:io';
import 'package:doc_talk/networks/api_client.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/change_password.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/profile.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/widgets/actionbutton.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/dashboard_data_controller.dart';
import '../../dashboard_home.dart';

class EditProfile extends StatefulWidget {
  static String route = 'edit-profile';
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // XFile? _image;
  // final ImagePicker _imgPic = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  bool updatingProfile = false;

  final List<String> _items = [
    'Consultant',
    'Resident',
    'Medical Officer',
    'Nurse',
  ];
  final DashboardDataController _controller =
  Get.put(DashboardDataController());
  UpdateProfileUpdate userProfileUpdate = UpdateProfileUpdate();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffebf2fa),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,

                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(()=> TextInputField(
                  titleText: 'Full Name',
                  onchange:(value){
                    userProfileUpdate.name = value;
                  },
                  hintText: 'Enter your full name',
                  controller: TextEditingController(text: _controller.dashboardDataModal.value.fullName),
                )),
                const SizedBox(
                  height: 15,
                ),

          Obx(()=>   TextInputField(
            onchange:(value){
              userProfileUpdate.speciality = value;
            },
                        titleText: 'Speciality',
                        hintText: 'Enter your speciality',
                        controller:
                            TextEditingController(text: _controller.dashboardDataModal.value.speciality),

          )),
                    const SizedBox(
                      width: 3,
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Text("I am a",
                    //         style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w100,
                    //             color: Colors.black)),
                    //     // Obx(()=>   DropdownButtonHideUnderline(
                    //     //     child: Padding(
                    //     //   padding: const EdgeInsets.only(top: 2),
                    //     //   child: DropdownButtonFormField(
                    //     //     decoration: const InputDecoration(
                    //     //       border: UnderlineInputBorder(),
                    //     //       hintText: "Select your Qualification",
                    //     //     ),
                    //     //     value: _controller.dashboardDataModal.value.qualification,
                    //     //     style: TextStyle(
                    //     //       fontSize: 16,
                    //     //       color: Theme.of(context).primaryColor,
                    //     //     ),
                    //     //     items: _items.map((e) {
                    //     //       return DropdownMenuItem(
                    //     //         value: e,
                    //     //         child: Text(e),
                    //     //       );
                    //     //     }).toList(),
                    //     //     onChanged: (value) {
                    //     //       setState(() {
                    //     //         _selectedValue = value.toString();
                    //     //       });
                    //     //     },
                    //     //   ),
                    //     // ))),
                    //   ],
                    // ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                updatingProfile==true? SizedBox():
                ActionButton(buttonText: 'Update', onPressed: () async {
                 setState(() {
                   updatingProfile = true;
                 });
                  UpdateProfileUpdate serverUpdate = UpdateProfileUpdate();

                  serverUpdate.name = userProfileUpdate.name ?? _controller.dashboardDataModal.value.fullName;
                  serverUpdate.speciality =  userProfileUpdate.speciality??_controller.dashboardDataModal.value.speciality;


                  await ApiClient().updateUserProfileDetail(map: serverUpdate.toJson(), accessToken: _controller.dashboardDataModal.value.accessToken!, userId: _controller.dashboardDataModal.value.id!);

                  await loadDashBoardData();
                 setState(() {
                   updatingProfile = false;
                 });

                }),
                const SizedBox(
                  height: 10,
                ),
                updatingProfile==true? SizedBox():
                ActionButton(
                    buttonText: 'Change Password',
                    onPressed: () {

                      Get.to(ChangePassword(accessToken: _controller.dashboardDataModal.value.accessToken!,));

                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }


}


class UpdateProfileUpdate {
  String? name;
  String?  speciality;
  // String ? qualification;
  // String? dob;

  Map<String, dynamic> toJson (){
    Map<String, dynamic> map;
    map = {
      "name":name,
      "speciality": speciality,
      //"qualification":qualification,
     // "dob":dob,
    };


    return map;

  }


}
