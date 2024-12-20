import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bluebutton extends StatelessWidget {
  final String title;
  final RxBool sendingData;
  final VoidCallback onTap;

  Bluebutton({
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
          color: AppColors.appBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Obx(() => sendingData.value
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : AppTextLabels.boldTextShort(
            label: title,
            color: Colors.white,
            fontSize: 15,
          ),
          ),
        ),
      ),
    );
  }
}
