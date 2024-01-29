import 'dart:ui' as ui;

import 'package:commons/commons.dart';
import 'package:finplus/constant/assets.gen.dart';
import 'package:finplus/layers/presentation/chat_room/controller.dart';
import 'package:finplus/layers/presentation/messages/view/messages_screen.dart';
import 'package:finplus/routes/routes.dart';
import 'package:finplus/styles/styles.dart';
import 'package:finplus/styles/text_define.dart';
import 'package:flutter/material.dart';

import '../../data/repository/chat_repository_impl.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatRoomController>(
      init: ChatRoomController(ChatRepositoryImpl()),
      builder: (c) {
        return Scaffold(
          appBar: const CustomAppbar(),
          body: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                  height: 1, color: neutral09, endIndent: 8, indent: 8),
              itemCount: c.rooms.length,
              itemBuilder: (_, i) {
                final roomInfo = c.rooms[i];

                return InkWell(
                  onTap: () => Get.to(MessagesScreen(roomId: roomInfo.id)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            Assets.images.avatar.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              roomInfo.name,
                              style: TextDefine.t2_B.copyWith(color: primary02),
                            ),
                            const Text('Tin nhắn chưa đọc hiện rõ hơn...'),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0xffE9A237), Color(0xff9A0000)]),
      ),
      child: SafeArea(
          child: Align(
              child: Text(
        'Tin nhắn',
        style: TextDefine.t2_B.copyWith(color: Colors.white),
      ))),
    );
  }

  @override
  ui.Size get preferredSize => AppBar().preferredSize;
}
