import 'package:commons/commons.dart';
import 'package:finplus/layers/presentation/chat_room/controller.dart';
import 'package:finplus/styles/styles.dart';
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
          body: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: neutral09),
              itemCount: c.rooms.length,
              itemBuilder: (_, i) => const Text('data'),
            ),
          ),
        );
      },
    );
  }
}
