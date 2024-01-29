import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:flutter/material.dart';

class StickerMessage extends StatelessWidget {
  final MessageModel message;

  final Alignment alignment;

  const StickerMessage(
      {super.key,
      required this.message,
      this.alignment = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      constraints: const BoxConstraints(maxWidth: 200),
      // child: VdiaryImage(
      //   width: 100,
      //   path: message.files.first,
      //   fit: BoxFit.contain,
      // ),
    );
  }
}
