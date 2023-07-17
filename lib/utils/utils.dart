import 'package:commons/commons.dart';

class Utils {
  static void showNotification(String? content) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    // Get.rawSnackbar(
    //   backgroundColor: Colors.transparent,
    //   padding: EdgeInsets.zero,
    //   snackPosition: SnackPosition.TOP,
    //   messageText: AppSnackBar(content: content?.tr ?? ''),
    // );
  }

  static bool validatePhoneNumber(String value) {
    final RegExp phoneReg =
        RegExp(r'((09|03|07|08|05)+([0-9]{8})\b)|((84)+([0-9]{9})\b)');
    return phoneReg.hasMatch(value);
  }
}
