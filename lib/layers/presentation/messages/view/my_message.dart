import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/styles/text_define.dart';
import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  final MessageModel message;

  final MessageModel? nextMessage;

  final MessageModel? previousMessage;

  const MyMessage({
    super.key,
    required this.message,
    this.nextMessage,
    this.previousMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isSameUser = message.isDoctor == nextMessage?.isDoctor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (message.content.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: isSameUser ? 2 : 8, left: 70),
            padding: const EdgeInsets.all(10).copyWith(top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: primary07,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                bottomLeft: const Radius.circular(15),
                topRight: Radius.circular(isSameUser ? 5 : 15),
                bottomRight: Radius.circular(previousMessage == null ||
                        (previousMessage != null &&
                            message.isDoctor != previousMessage?.isDoctor)
                    ? 15
                    : 5),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        message.content,
                        style: TextDefine.t2_R.copyWith(color: Colors.white),
                      ),
                    ),
                    // const SizedBox(width: 4),
                    // Text(
                    //   Utils.formatDateToDisplay(message.createdAt, 'HH:mm'),
                    //   style:
                    //       TextDefine.P4_R.copyWith(color: Colors.transparent),
                    // ),
                  ],
                ),
                // Positioned(
                //   bottom: -4,
                //   right: 0,
                //   child: Text(
                //     Utils.formatDateToDisplay(message.createdAt, 'HH:mm'),
                //     style: TextDefine.P4_R.copyWith(color: AppColors.darkGrey),
                //   ),
                // )
              ],
            ),
          ),
        // if (message.files.isNotEmpty && message.isImage)
        //   SingleImageMessage(
        //     message: message,
        //     alignment: Alignment.centerRight,
        //   ),
        // if (message.isSticker && message.files.isNotEmpty)
        //   StickerMessage(
        //     message: message,
        //     alignment: Alignment.centerRight,
        //   ),
        // if (message.files.isNotEmpty && message.isAudio)
        //   AudioMessage(
        //     message: message,
        //     alignment: Alignment.centerRight,
        //   ),
        // if (message.isVideo)
        //   VideoMessage(
        //     message: message,
        //     alignment: Alignment.centerRight,
        //   ),
      ],
    );
  }
}
