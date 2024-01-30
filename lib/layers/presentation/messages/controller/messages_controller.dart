import 'dart:async';
import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:either_dart/either.dart';
import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:finplus/layers/domain/entities/room_model.dart';
import 'package:finplus/layers/domain/entities/user_model.dart';
import 'package:finplus/layers/domain/repository/chat_repository.dart';
import 'package:finplus/layers/presentation/calling/calling.dart';
import 'package:finplus/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

class MessagesController extends GetxController {
  final int roomId;

  final ChatRepository _chatRepository;

  late final TextEditingController messageInput;

  late final FocusNode messageInputFocusNode;

  final Rx<List<MessageModel>> _messages = Rx([]);

  List<MessageModel> get messages => _messages.value;

  final RxBool _hasFocus = RxBool(false);

  bool get hasFocus => _hasFocus.value;

  final Rxn<RoomModel> _roomInfo = Rxn();

  RoomModel? get roomInfo => _roomInfo.value;

  final Rx<UserModel?> _user =
      Rx(Storage.get(KEY.LOGIN_DATA, UserModel.fromJson));

  UserModel? get user => _user.value;

  int page = 1;

  bool hasMore = true;

  final Completer _completer = Completer();

  late final StompClient client = StompClient(
      config: StompConfig.sockJS(
    url: 'https://rehab.serveo.net/ws',
    onConnect: (p0) {
      print('connected');
      _completer.complete();
    },
    onWebSocketError: (p0) {
      print(p0);
    },
  ));

  MessagesController(
    this._chatRepository,
    this.roomId,
  );

  @override
  Future<void> onInit() async {
    messageInputFocusNode = FocusNode();

    messageInput = TextEditingController();

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    messageInputFocusNode.addListener(() {
      _hasFocus(messageInputFocusNode.hasFocus);
    });

    _loadMessages();

    client.activate();

    await _completer.future;

    client.subscribe(
      destination: '/topic/public',
      callback: (p0) {
        _receivedNewMessage(json.decode(p0.body ?? json.encode({})));
      },
    );

    super.onReady();
  }

  Future<void> _loadMessages() async {
    final res = await _chatRepository.getMessages(roomId: roomId);

    res.map((right) {
      page++;
      if (right != null) {
        _handleResponseMessageData(right);

        hasMore = right.length >= 20;
      }
    });
  }

  void _receivedNewMessage(Map<String, dynamic> value) {
    switch (value['type']) {
      case 'CHAT':
        final newMessage = MessageModel.fromJson(value['data']);

        if (newMessage.isDoctor == user?.isDoctor) {
          _messages.update((val) {
            val?.insert(0, newMessage);
          });
        }
        break;
      case 'CALL':
        Get.to(() => const Calling());
        break;

      default:
    }
  }

  void _handleResponseMessageData(List<MessageModel> value) {
    final PriorityQueue<MessageModel> data = PriorityQueue<MessageModel>(
        (p0, p1) => p1.createdAt.millisecondsSinceEpoch
            .compareTo(p0.createdAt.millisecondsSinceEpoch));

    final oldMessage = [...messages];

    value.forEach((e) {
      oldMessage.removeWhere((element) => element.id == e.id);
    });

    data.addAll([...oldMessage, ...value]);

    _messages(data.toList());
  }

  void sendMessage() {
    if (messageInput.text.trim().isNotEmpty) {
      final content = messageInput.text;
      messageInput.clear();

      _onSendMessage(content: content);
    }
  }

  void _onSendMessage({String? content}) {
    final res = _chatRepository.sendMessage(roomId, content);

    res.mapRight((right) {
      if (right != null) {
        _messages.update((val) {
          val?.insert(0, right);
          _sendMessageToSocket(right);
        });
      }
    });
  }

  void _sendMessageToSocket(MessageModel message) {
    _send('CHAT', {
      ...message.toJson(),
      ...{'isDoctor': user?.isDoctor ?? true},
    });
  }

  void startCall() {
    _send('CALL', {});
  }

  void _send(String type, Map<String, dynamic> data) {
    client.send(
      destination: '/topic/public',
      body: json.encode({'type': type, 'data': data}),
      headers: {'content-type': 'application/json'},
    );
  }

  @override
  void onClose() {
    messageInput.dispose();
    messageInputFocusNode.dispose();
    super.onClose();
  }
}
