import 'package:commons/commons.dart';
import 'package:finplus/screens/CreatePassWord/controller.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/widgets/BackButtonApp/index.dart';
import 'package:finplus/widgets/Buttom/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../routes/routes.dart';
import '../../utils/svg.dart';
import '../../widgets/CustomTextField/index.dart';

class CreatePassWord extends StatelessWidget {
  const CreatePassWord({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePassWordController>(
      init: CreatePassWordController(),
      builder: (c) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            leading: BackButtonApp(
                isBack: true, onPressed: () => Get.toNamed(Routes.sign_up)),
            elevation: 0,
            title: const Text('Tạo Mật Khẩu'),
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
                const SizedBox(height: 20),
                Obx(
                  () => CustomTextField(
                    obscureText: !c.showConfirmPassword.value,
                    controller: c.confirmPassWord,
                    focusNode: c.confirmPassWordFocus,
                    hintText: 'Nhập lại mật khẩu',
                    labelText: 'Xác Nhận Mật khẩu',
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    suffixIcon: InkWell(
                      onTap: c.showPassword.toggle,
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
