import 'package:accurate/components/SwipeableTabs.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/user/UserProfile/Controllers/UserProfileController.dart';
import 'package:accurate/user/UserProfile/Views/DevicesScreen.dart';
import 'package:accurate/user/UserProfile/Views/DocumentScreen.dart';
import 'package:accurate/user/UserProfile/Views/Personalnfo.dart';
import 'package:accurate/user/UserProfile/Views/VehicleScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {


  late UserProfileController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(UserProfileController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    Get.delete<UserProfileController>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            NavWithBack(),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() :
            Column(
              children: [
                CustomTabs(
                  tabTitles: [
                    'Personal Info',
                    'Documents',
                    'Devices',
                    'Vechicels',
                  ],
                  tabContents: [
                    PersonalInfo(info: controller.details,),
                    DocumentScreen(info: controller.details,),
                    DevicesScreen(info: controller.details,),
                    VehicleScreen(info: controller.details,)
                  ],
                ),
              ],
            ))
          ],
        )));
  }
}
