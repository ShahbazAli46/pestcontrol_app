import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertService {
  static void showAlert(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void showAlertWithAction(
      String title,
      String message, {
        required Function onOkPressed,
      }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              onOkPressed();
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void showAlertWithCancelButton(
      String title,
      String message, {
        required Function onOkPressed,
      }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              onOkPressed(); // Trigger the OK action
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void showUpdateAppAlert({
    required String title,
    required String message,
    required Function onUpdatePressed,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              onUpdatePressed(); // Trigger the update action
            },
            child: const Text('Update App'),
          ),
        ],
      ),
      barrierDismissible: false, // Prevent dismissing the alert by tapping outside
    );
  }

}