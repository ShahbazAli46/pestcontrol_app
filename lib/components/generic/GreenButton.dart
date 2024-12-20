import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/TextStyle.dart';
import '../../utils/appColors.dart';

class GreenButton extends StatelessWidget {
  final String title;
  final Rx<bool> sendingData;
  final VoidCallback onTap;

  GreenButton({
    required this.title,
    required this.sendingData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.appGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Obx(() {
            if (sendingData.value) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              );
            } else {
              return AppTextLabels.boldTextShort(
                label: title,
                color: Colors.white,
                fontSize: 15,
              );
            }
          }),
        ),
      ),
    );
  }
}