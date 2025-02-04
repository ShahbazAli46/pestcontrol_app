



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/TextStyle.dart';
import '../../utils/appColors.dart';

class GreenButtonBordered extends StatelessWidget {
  final String title;
  final Rx<bool> sendingData;
  final VoidCallback onTap;

  GreenButtonBordered({
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
          border: Border.all(color: AppColors.appGreen), // Add border
          borderRadius: BorderRadius.circular(8), // Set border radius to 8
        ),
        child: Center(
          child: Obx(() {
            if (sendingData.value) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.appGreen), // Use appGreen for progress indicator
              );
            } else {
              return AppTextLabels.boldTextShort(
                label: title,
                color: AppColors.appGreen, // Use appGreen for text color
                fontSize: 15,
              );
            }
          }),
        ),
      ),
    );
  }
}