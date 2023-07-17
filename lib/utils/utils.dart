import 'package:commons/commons.dart';
import 'package:finplus/base/base.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

enum NOTIFICATION_TYPE { SUCCESS, ERROR }

class Utils {
  static void showNotification(NOTIFICATION_TYPE type,
      [String? title, String? notification, Color? color]) {
    final notificationColor = {
      NOTIFICATION_TYPE.SUCCESS: color ?? theme.primary03,
      NOTIFICATION_TYPE.ERROR: theme.error04,
    };

    Get.rawSnackbar(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: notificationColor[type]!,
        messageText: Text(
          notification?.tr ?? '',
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ));
  }

  static bool validatePhoneNumber(String value) {
    final RegExp phoneReg =
        RegExp(r'((09|03|07|08|05)+([0-9]{8})\b)|((84)+([0-9]{9})\b)');
    return phoneReg.hasMatch(value);
  }
}

extension GetResponseExtension on ApiResponse {
  void showError(String title) {
    final notification =
        undecodeData is Map ? undecodeData['message']?.toString().tr : null;
    if (undecodeData['message'] == notification) {
      Utils.showNotification(NOTIFICATION_TYPE.ERROR, title,
          undecodeData['message'] ?? notification);
    } else {
      Utils.showNotification(
        NOTIFICATION_TYPE.ERROR,
        title,
        notification,
      );
    }
  }
}
