import 'package:commons/commons.dart';
import 'package:finplus/screens/Login/controller.dart';
import 'package:finplus/screens/SignUp/index.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/styles/text_define.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/utils/utils.dart';
import 'package:finplus/widgets/Buttom/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/CustomTextField/index.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (c) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text('Đăng Nhập'),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
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
                          const SizedBox(height: 20),
                          Obx(
                            () => CustomTextField(
                              obscureText: !c.showPassword.value,
                              controller: c.password,
                              focusNode: c.passwordFocus,
                              stringError: c.passwordError.value,
                              showError: c.passwordError.value.isNotEmpty,
                              hintText: 'Nhập mật khẩu',
                              labelText: 'Mật khẩu',
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
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () => Get.to(() => const SignUp(
                                type: CHANGE_PASSWORD_TYPE.FORGOT_PASSWORD)),
                            child: Text(
                              'Quên mật khẩu ?',
                              style:
                                  TextDefine.te1_R.copyWith(color: primary03),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(height: 50)
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Obx(
                          () => Button(
                              onPressed: c.onConfirm,
                              text: 'Đăng nhập',
                              enabled: c.enabled.value),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () => Get.to(() =>
                              const SignUp(type: CHANGE_PASSWORD_TYPE.SIGNUP)),
                          child: Text.rich(TextSpan(
                              style: TextDefine.t2_R.copyWith(color: neutral00),
                              text: 'Bạn chưa có tài khoản? ',
                              children: [
                                TextSpan(
                                  text: 'Đăng ký',
                                  style: TextDefine.t2_R
                                      .copyWith(color: primary03),
                                )
                              ])),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
