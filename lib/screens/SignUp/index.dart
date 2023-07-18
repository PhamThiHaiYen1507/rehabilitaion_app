import 'package:commons/commons.dart';
import 'package:finplus/screens/SignUp/controller.dart';
import 'package:finplus/utils/utils.dart';
import 'package:finplus/widgets/Buttom/index.dart';
import 'package:flutter/material.dart';

import '../../utils/svg.dart';
import '../../widgets/BackButtonApp/index.dart';
import '../../widgets/CustomTextField/index.dart';

class SignUp extends StatelessWidget {
  final CHANGE_PASSWORD_TYPE type;
  const SignUp({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(type),
        builder: (c) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
                appBar: AppBar(
                  leading: BackButtonApp(isBack: true, onPressed: Get.back),
                  elevation: 0,
                  title: Text(type == CHANGE_PASSWORD_TYPE.SIGNUP
                      ? 'Đăng ký'
                      : type == CHANGE_PASSWORD_TYPE.FORGOT_PASSWORD
                          ? 'Quên mật khẩu'
                          : 'Đổi mật khẩu'),
                  centerTitle: true,
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Image.asset(Picture.login_logo),
                            const SizedBox(height: 20),
                            Obx(
                              () => CustomTextField(
                                keyboardType: TextInputType.number,
                                controller: c.phoneNumber,
                                focusNode: c.phoneNumberFocus,
                                showError: c.phoneNumberError.value.isNotEmpty,
                                stringError: c.phoneNumberError.value,
                                hintText: 'Nhập số điện thoại',
                                labelText: 'Số điện thoại',
                              ),
                            ),
                            const SizedBox(height: 50)
                          ],
                        ),
                      ),
                      Obx(
                        () => Button(
                            onPressed: c.onConfirm,
                            text: 'Tiếp tục',
                            enabled: c.enabled.value),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
