import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showDialog({required String msg}) {
    Get.defaultDialog(
      title: 'Alert',
      middleText: msg,
      backgroundColor: Colors.white,
      radius: 8.0,
      barrierDismissible: false,
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}