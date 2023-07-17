import 'package:finplus/styles/styles.dart';
import 'package:flutter/material.dart';

class BackButtonApp extends StatelessWidget {
  final bool isBack;
  final VoidCallback? onPressed;
  const BackButtonApp(
      {super.key, required this.isBack,  this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed?.call(),
      child: Icon(
        isBack ? Icons.arrow_back_ios_new : Icons.cancel,
        color: theme.primary03,
        size: 20,
      ),
    );
  }
}
