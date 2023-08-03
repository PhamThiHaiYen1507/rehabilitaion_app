import 'package:finplus/styles/styles.dart';
import 'package:finplus/styles/text_define.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? stringError;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool showError;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? prefixPadding;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.keyboardType,
    this.stringError,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.inputFormatters,
    this.focusNode,
    this.obscureText = false,
    this.showError = true,
    this.textInputAction,
    this.prefixPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool haveErr = stringError != null && stringError!.isNotEmpty;
    return Column(
      children: [
        TextField(
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: style ?? TextDefine.t2_R.copyWith(color: neutral00),
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            isDense: true,
            //hintText: hintText,
            labelText: labelText,
            labelStyle: TextStyle(color: theme.primary03),
            errorText: haveErr ? '' : null,
            errorStyle: const TextStyle(height: 0),
            errorMaxLines: 1,
            prefixIcon: prefixIcon != null
                ? Container(
                    width: 20 + 24 + 7,
                    padding: prefixPadding ?? const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(1).copyWith(
                      right: 6,
                    ),
                    child: Center(child: prefixIcon),
                  )
                : null,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 1, color: theme.primary03),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 1, color: theme.primary03)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 1, color: theme.primary03)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 2, color: theme.primary04)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 1, color: theme.error04)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 1, color: theme.error04)),
          ),
        ),
        if (haveErr && showError)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: theme.error04),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: Text(
                    stringError!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: theme.error04,
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
