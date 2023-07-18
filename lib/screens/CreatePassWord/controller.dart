import 'package:commons/commons.dart';
import 'package:finplus/providers/login_provider.dart';
import 'package:finplus/utils/utils.dart';
import 'package:flutter/widgets.dart';

import '../../routes/routes.dart';

class CreatePassWordController extends GetxController {
  final String phoneNumber;
  final CHANGE_PASSWORD_TYPE type;
  late final LoginProvider loginProvider;
  late final TextEditingController password, confirmPassWord;
  late final FocusNode passwordFocus, confirmPassWordFocus;
  late final RxString confirmPassWordError;
  late final RxBool showPassword, showConfirmPassword, enabled;

  CreatePassWordController(this.phoneNumber, this.type);

  @override
  void onInit() {
    loginProvider = LoginProvider();
    password = TextEditingController();
    confirmPassWord = TextEditingController();
    passwordFocus = FocusNode();
    confirmPassWordFocus = FocusNode();
    confirmPassWordError = RxString('');
    showPassword = RxBool(false);
    showConfirmPassword = RxBool(false);
    enabled = RxBool(false);
    super.onInit();
  }

  Future<void> onConfirm() async {
    passwordFocus.unfocus();
    confirmPassWordFocus.unfocus();
    if (password.text.trim() == confirmPassWord.text.trim()) {
      final bool result = await loginProvider.createPassWord(
          phoneNumber: phoneNumber, password: password.text);
      if (result)
        Utils.showPopup(
            barrierDismissible: false,
            title: type == CHANGE_PASSWORD_TYPE.SIGNUP
                ? 'Tạo tài khoản thành công'
                : 'Đổi mật khẩu thành công',
            onConfirm: () => type == CHANGE_PASSWORD_TYPE.SIGNUP
                ? Get.offAllNamed(Routes.home)
                : type == CHANGE_PASSWORD_TYPE.FORGOT_PASSWORD
                    ? Utils.backToRoutes(Routes.login)
                    : Get.back());
    } else {
      confirmPassWordError('Mật khẩu không khớp');
    }
  }

  @override
  void onClose() {
    password.dispose();
    confirmPassWord.dispose();
    passwordFocus.dispose();
    confirmPassWordFocus.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    password.addListener(() {
      confirmPassWord.addListener(() {
        enabled(password.text.trim().isNotEmpty &&
            confirmPassWord.text.trim().isNotEmpty);
      });
    });
    super.onReady();
  }
}
