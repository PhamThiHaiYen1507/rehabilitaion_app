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
}
