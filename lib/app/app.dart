import 'package:commons/commons.dart';
import 'package:finplus/app/app_bindings.dart';
import 'package:finplus/routes/routes.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/utils/types.dart';
import 'package:flutter/material.dart';

class Healhub extends StatelessWidget {
  const Healhub({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: StyleConfigs.light,
      darkTheme: StyleConfigs.dark,
      themeMode: ThemeMode.light,
      initialBinding: AppBindings(),
      getPages: AppNavigate.screens,
      initialRoute:
          Storage.get(KEY.LOGIN_DATA) != null ? Routes.home : Routes.login,
    );
  }
}
