import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:flutter/material.dart';

class AudioMessage extends StatelessWidget {
  final MessageModel message;

  final Alignment alignment;
  const AudioMessage(
      {super.key,
      required this.message,
      this.alignment = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      // child: AudioPlayerDiary(
      //   showDeleteButton: false,
      //   height: 36,
      //   source: message.files.first.mediaLink,
      // ),
    );
  }
}
