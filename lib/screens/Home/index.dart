import 'package:commons/commons.dart';
import 'package:finplus/routes/routes.dart';
import 'package:finplus/widgets/Buttom/index.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
      child: Column(
        children: [
          const Expanded(child: SizedBox()),
          Button(
              onPressed: () => Get.offAllNamed(Routes.login), text: 'Đăng xuất')
        ],
      ),
    );
  }
}
