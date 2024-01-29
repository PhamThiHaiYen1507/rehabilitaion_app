import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:flutter/material.dart';

class VideoMessage extends StatelessWidget {
  final MessageModel message;
  final Alignment alignment;
  const VideoMessage(
      {super.key,
      required this.message,
      this.alignment = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    if (message.fileMain == null) return const SizedBox();

    return Container(
      margin: EdgeInsets.only(
          left: alignment == Alignment.centerLeft ? 0 : 50,
          right: alignment == Alignment.centerRight ? 0 : 50),
      // child: VdiaryVideoPlayer(
      //   url: message.fileMain!,
      //   isInview: false,
      // ),
    );
  }
}
