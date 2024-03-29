import 'package:finplus/styles/styles.dart';
import 'package:finplus/styles/text_define.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String text;
  final num height;
  final Alignment alignment;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? disableColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? side;
  final bool enabled;

  const Button({
    Key? key,
    required this.onPressed,
    this.child,
    this.height = 54,
    this.alignment = Alignment.center,
    this.fullWidth = true,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.side,
    this.disableColor,
    this.enabled = true,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.toDouble(),
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                // ignore: use_named_constants
                end: const Alignment(1, 1),
                colors: enabled
                    ? <Color>[
                        const Color(0xffE9A237),
                        const Color(0xff9A0000),
                      ]
                    : <Color>[
                        const Color(0xffE9A237).withOpacity(0.5),
                        const Color(0xff9A0000).withOpacity(0.5),
                      ],
                tileMode: TileMode.mirror,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(100),
            ),
            child: fullWidth == true
                ? Align(
                    alignment: alignment,
                    child: child ??
                        Text(text,
                            style: TextDefine.t1_B.copyWith(
                                color: !enabled
                                    ? theme.neutral09
                                    : theme.neutral10)),
                  )
                : child),
      ),
    );
  }
}
