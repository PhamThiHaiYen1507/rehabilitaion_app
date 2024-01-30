import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:flutter/material.dart';

class FriendMessage extends StatelessWidget {
  final MessageModel message;

  final MessageModel? nextMessage;

  final MessageModel? previousMessage;

  final bool showAvatar;

  const FriendMessage({
    super.key,
    required this.message,
    this.nextMessage,
    this.previousMessage,
    this.showAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSameUser = message.isDoctor == nextMessage?.isDoctor;

    return Container(
      padding:
          const EdgeInsets.only(right: 50).copyWith(top: isSameUser ? 2 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showAvatar) ...[
            if (!isSameUser)
              //   AvatarCircle(
              //     dimensions: 38,
              //     avatar: message.user?.avatar ?? '',
              //     size: 150,
              //   )
              // else
              const SizedBox(width: 38),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (message.content.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.all(10).copyWith(top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                        topLeft: Radius.circular(isSameUser ? 5 : 15),
                        bottomLeft: Radius.circular(previousMessage == null ||
                                (previousMessage != null &&
                                    message.isDoctor !=
                                        previousMessage?.isDoctor)
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
                              child: Text(message.content),
                            ),
                            // const SizedBox(width: 4),
                            // Text(
                            //   Utils.formatDateToDisplay(
                            //       message.createdAt, 'HH:mm'),
                            //   style: TextDefine.P4_R
                            //       .copyWith(color: Colors.transparent),
                            // )
                          ],
                        ),
                        // Positioned(
                        //   right: 0,
                        //   bottom: -4,
                        //   child: Text(
                        //     Utils.formatDateToDisplay(
                        //         message.createdAt, 'HH:mm'),
                        //     style: TextDefine.P4_R,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                // if (message.files.isNotEmpty && message.isImage)
                //   SingleImageMessage(
                //     message: message,
                //     alignment: Alignment.centerLeft,
                //   ),
                // if (message.isSticker && message.files.isNotEmpty)
                //   StickerMessage(
                //     message: message,
                //     alignment: Alignment.centerLeft,
                //   ),
                // if (message.files.isNotEmpty && message.isAudio)
                //   AudioMessage(
                //     message: message,
                //     alignment: Alignment.centerLeft,
                //   ),
                // if (message.isVideo)
                //   VideoMessage(
                //     message: message,
                //     alignment: Alignment.centerLeft,
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
