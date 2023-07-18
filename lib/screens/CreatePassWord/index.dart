import 'package:commons/commons.dart';
import 'package:finplus/screens/CreatePassWord/controller.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/widgets/BackButtonApp/index.dart';
import 'package:finplus/widgets/Buttom/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/svg.dart';
import '../../utils/utils.dart';
import '../../widgets/CustomTextField/index.dart';

class CreatePassWord extends StatelessWidget {
  final String phoneNumber;
  final CHANGE_PASSWORD_TYPE type;
  const CreatePassWord(
      {super.key, required this.phoneNumber, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePassWordController>(
      init: CreatePassWordController(phoneNumber, type),
      builder: (c) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            leading: BackButtonApp(isBack: true, onPressed: () => Get.back()),
            elevation: 0,
            title: Text(type == CHANGE_PASSWORD_TYPE.SIGNUP
                ? 'Tạo Mật Khẩu'
                : type == CHANGE_PASSWORD_TYPE.FORGOT_PASSWORD
                    ? 'Quên mật khẩu'
                    : 'Đổi mật khẩu'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
            child: Column(children: [
              Expanded(
                  child: ListView(children: [
                Image.asset(Picture.login_logo),
                const SizedBox(height: 20),
                Obx(
                  () => CustomTextField(
                    obscureText: !c.showPassword.value,
                    controller: c.password,
                    focusNode: c.passwordFocus,
                    hintText: type == CHANGE_PASSWORD_TYPE.SIGNUP
                        ? 'Nhập mật khẩu'
                        : 'Nhập mật khẩu mới',
                    labelText: type == CHANGE_PASSWORD_TYPE.SIGNUP
                        ? 'Mật khẩu'
                        : 'Mật khẩu mới',
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    suffixIcon: InkWell(
                      onTap: c.showPassword.toggle,
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: Center(
                          child: c.showPassword.value
                              ? Icon(Icons.remove_red_eye_outlined,
                                  color: theme.neutral00)
                              : SvgPicture.asset(
                                  SvgIcon.hide_password,
                                  height: 18,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CustomTextField(
                    obscureText: !c.showConfirmPassword.value,
                    controller: c.confirmPassWord,
                    focusNode: c.confirmPassWordFocus,
                    showError: c.confirmPassWordError.value != null,
                    stringError: c.confirmPassWordError.value,
                    hintText: type == CHANGE_PASSWORD_TYPE.SIGNUP
                        ? 'Nhập lại mật khẩu'
                        : 'Nhập lại mật khẩu mới',
                    labelText: type == CHANGE_PASSWORD_TYPE.SIGNUP
                        ? 'Xác nhận mật khẩu'
                        : 'Xác nhận mật khẩu mới',
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    suffixIcon: InkWell(
                      onTap: c.showConfirmPassword.toggle,
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: Center(
                          child: c.showConfirmPassword.value
                              ? Icon(Icons.remove_red_eye_outlined,
                                  color: theme.neutral00)
                              : SvgPicture.asset(
                                  SvgIcon.hide_password,
                                  height: 18,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ])),
              Obx(
                () => Button(
                    onPressed: c.onConfirm,
                    text: 'Tiếp tục',
                    enabled: c.enabled.value),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
