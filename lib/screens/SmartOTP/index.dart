import 'package:commons/commons.dart';
import 'package:finplus/screens/CreatePassWord/index.dart';
import 'package:finplus/screens/SmartOTP/controller.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/styles/text_define.dart';
import 'package:finplus/utils/utils.dart';
import 'package:finplus/widgets/BackButtonApp/index.dart';
import 'package:finplus/widgets/Buttom/index.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/svg.dart';

class SmartOTP extends StatelessWidget {
  final String phoneNumber;
  final CHANGE_PASSWORD_TYPE type;
  const SmartOTP({super.key, required this.phoneNumber, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartOTPController>(
        init: SmartOTPController(),
        builder: (c) => GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
                appBar: AppBar(
                  leading:
                      BackButtonApp(isBack: true, onPressed: () => Get.back()),
                  elevation: 0,
                  title: const Text('Xác thực OTP'),
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
                            const Text('Nhập mã xác thực được gửi về số',
                                style: TextDefine.t2_R,
                                textAlign: TextAlign.center),
                            Text(phoneNumber,
                                style: TextDefine.t1_B
                                    .copyWith(color: theme.primary04),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            Center(
                              child: Pinput(
                                focusNode: c.otpFocus,
                                controller: c.otp,
                                autofocus: true,
                                length: 4,
                                focusedPinTheme: PinTheme(
                                  height: 65,
                                  width: 55,
                                  textStyle: TextDefine.h1_B.copyWith(
                                    color: theme.primary04,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: theme.primary03),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                defaultPinTheme: PinTheme(
                                  height: 65,
                                  width: 55,
                                  textStyle: TextDefine.h1_B.copyWith(
                                    color: theme.primary04,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: theme.neutral00),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Column(
                          children: [
                            Button(
                                onPressed: () => Get.to(() => CreatePassWord(
                                    phoneNumber: phoneNumber, type: type)),
                                text: 'Tiếp tục',
                                enabled: c.enabled.value),
                            const SizedBox(height: 5),
                            Obx(
                              () => c.timeRefest.value <= 0
                                  ? InkWell(
                                      onTap: c.onRefest,
                                      child: Text('Gửi lại mã xác thực',
                                          style: TextDefine.t2_R
                                              .copyWith(color: primary03)))
                                  : Text.rich(TextSpan(
                                      style: TextDefine.t2_R
                                          .copyWith(color: neutral00),
                                      text: 'Vui lòng chờ ',
                                      children: [
                                          TextSpan(
                                            text: c.timeRefest.value.toString(),
                                            style: TextDefine.t2_R
                                                .copyWith(color: primary03),
                                          ),
                                          TextSpan(
                                            text: ' giây để nhận được mã',
                                            style: TextDefine.t2_R
                                                .copyWith(color: neutral00),
                                          )
                                        ])),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
