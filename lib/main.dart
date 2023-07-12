import 'package:finplus/app/app.dart';
import 'package:finplus/config.dart';
import 'package:finplus/global.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  setAppDevelopment();
  await Global.initial();
  runApp(const Healhub());
}
