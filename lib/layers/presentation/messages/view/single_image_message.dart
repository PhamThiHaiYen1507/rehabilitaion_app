import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:flutter/material.dart';

class SingleImageMessage extends StatelessWidget {
  final MessageModel message;
  final Alignment alignment;
  const SingleImageMessage({
    super.key,
    required this.message,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      alignment: alignment,
      constraints: const BoxConstraints(maxWidth: 260),
      child: const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        // child: VdiaryImage(
        //   width: 260,
        //   path: message.files.first,
        //   fit: BoxFit.contain,
        //   size: 700,
        //   placeholder: (context, url) => VdiaryImage(
        //     path: message.files.first,
        //     size: 50,
        //     width: 260,
        //     fit: BoxFit.contain,
        //     placeholder: (context, url) => const SizedBox.square(
        //       dimension: 120,
        //       child: Center(child: CircularProgressIndicator()),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
