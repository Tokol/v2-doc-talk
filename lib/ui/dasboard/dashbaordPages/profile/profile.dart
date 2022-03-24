// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:doc_talk/helper/utils.dart';
import 'package:doc_talk/ui/auth/splash_screen.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/edit_profile.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/widgets/actionbutton.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/widgets/bottom_modal.dart';
import 'package:doc_talk/ui/dasboard/dashbaordPages/profile/widgets/buttom_icon_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/dashboard_data_controller.dart';
import '../../../../networks/api_client.dart';

enum IMAGESOURCE { CAMERA, GALLERY }

class UserProfile extends StatefulWidget {

  @override
  _UserProfileState createState() => _UserProfileState();


  bool logout(){
    Get.to(SplashScreen());
    return true;
  }
}

class _UserProfileState extends State<UserProfile> {

  final DashboardDataController _controller =
      Get.put(DashboardDataController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body:
            profileView() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Center(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: SizedBox(
              width: 125,
              height: 125,
              child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    Obx(() {
                      if (_controller.fileImage.value != "") {
                        return CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              FileImage(File(_controller.fileImage.value)),
                        );
                      } else if (_controller.dashboardDataModal.value.image !=
                          null) {
                        return CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              _controller.dashboardDataModal.value.image!),
                        );
                      }
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          _controller.dashboardDataModal.value.fullName==null?"Null Value":
                           Utils.getShortCutOfString(
                             
                                  longValue: _controller
                                      .dashboardDataModal.value.fullName!),

                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.camera_fill,
                              color: Theme.of(context).primaryColor,
                              size: 15,
                            ),
                            onPressed: () {
                              bottomModal(
                                  height: 150,
                                  context: context,
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Container(
                                        height: 150,
                                        child: Column(
                                          children: <Widget>[
                                            BottomIconButton(
                                              onPressed: () {
                                                changeProfilePic(
                                                    IMAGESOURCE.CAMERA);
                                              },
                                              icon: Icons.photo_camera,
                                              title: 'Take photo from Camera',
                                            ),
                                            BottomIconButton(
                                              onPressed: () {
                                                changeProfilePic(
                                                    IMAGESOURCE.GALLERY);
                                              },
                                              icon: Icons.photo,
                                              title:
                                                  'Take photo from Image Gallery',
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ));
                            },
                          ),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.white),
                              color: Color(0xEFEFEFEF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        )),
                  ]),
            ),
          ),
          Obx(
            () => Text(
              _controller.dashboardDataModal.value.fullName!,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Obx(
            () => Text(
              _controller.dashboardDataModal.value.speciality!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 20,
      ),
      Expanded(
        flex: 7,
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ProfileListItem(
                icon: FontAwesomeIcons.gear,
                text: 'Account Settings',
                onTap: () {
                  Get.to(EditProfile());
                },
              ),
              ProfileListItem(
                icon: FontAwesomeIcons.triangleExclamation,
                text: 'Report a Problem',
              ),
              ProfileListItem(
                icon: CupertinoIcons.exclamationmark_shield,
                text: 'Privacy Policy',
              ),
              ProfileListItem(
                icon: FontAwesomeIcons.book,
                text: 'Terms & Conditions',
              ),
              ProfileListItem(
                icon: FontAwesomeIcons.bell,
                text: 'Disclaimer',
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ActionButton(
                  onPressed: ()  async {
                    await ApiClient().logout(accessToken: _controller.dashboardDataModal.value.accessToken);

                    widget.logout();
                  },
                  buttonText: 'Sign Out',
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  changeProfilePic(IMAGESOURCE imageSource) async {
    Navigator.pop(context);
    final ImagePicker _picker = ImagePicker();
    XFile? image;
    imageSource == IMAGESOURCE.CAMERA
        ? image = await _picker.pickImage(source: ImageSource.camera)
        : image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (image != null && image != "") {
        Get.find<DashboardDataController>().updateFileImage(image.path);
        final DashboardDataController _controller =
        Get.put(DashboardDataController());
         await ApiClient().changeUserProfileImage(accessToken: _controller.dashboardDataModal.value.accessToken!, userId: _controller.dashboardDataModal.value.id!, image: image!);
      }
    }
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  // ignore: prefer_typing_uninitialized_variables
  final text;
  final bool hasNavigation;
  final Function? onTap;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        height: 60,
        margin: EdgeInsets.only(left: 10, right: 10, top: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xff5A227E),
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff5A227E),
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (hasNavigation)
                Icon(
                  FontAwesomeIcons.angleRight,
                  size: 20,
                  color: Color(0xff5A227E),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


