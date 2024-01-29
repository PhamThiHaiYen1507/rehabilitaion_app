import 'package:commons/commons.dart';
import 'package:finplus/layers/domain/entities/message_model.dart';
import 'package:finplus/layers/domain/entities/room_model.dart';
import 'package:finplus/layers/domain/repository/chat_repository.dart';
import 'package:flutter/material.dart';

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

  int page = 1;

  bool hasMore = true;

  MessagesController(
    this._chatRepository,
    this.roomId,
  ) : super() {
    // _messages = Rx(BackgroundUploader().getSendingMessageWithRoomId(roomId));
  }

  @override
  Future<void> onInit() async {
    // _record = Record();

    // _socket = io(
    //   '${AppConfig.chatSocketUrl}/conversation',
    //   OptionBuilder()
    //       .setTransports(['websocket'])
    //       .disableAutoConnect()
    //       .setQuery({
    //         'token': StorageLocal.get(KEY.TOKEN),
    //         'userId': UserStorageHelper.userData?.sId,
    //       })
    //       .setAuth({'token': StorageLocal.get(KEY.TOKEN)})
    //       .enableForceNewConnection()
    //       .enableForceNew()
    //       .build(),
    // );

    // add(MessagesBlocGetRoomInfo());

    // add(MessagesBlocGetMessages());

    // _debouncer = Debouncer();

    messageInputFocusNode = FocusNode();

    messageInput = TextEditingController();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // _socket.connect();

    // _socket.onConnect((data) {
    //   logD('Connected room: $roomId');
    //   _askDispatchActions(
    //       'conversations/join-room', {'conversationId': roomId});
    // });

    // _socket.onError((data) {
    //   logE('Message socket connect error: $data');
    // });

    // // _socket.on('new_message_in_room', _onNewMessage);
    // _socket.on('conversation/new_message_in_room', _onNewMessage);

    messageInputFocusNode.addListener(() {
      _hasFocus(messageInputFocusNode.hasFocus);
    });

    _loadRoomInfo();

    _loadMessages();

    super.onReady();
  }

  // @override
  // void registerEvent() {
  //   on(_loadRoomInfo);

  //   on(_loadMessages);

  //   on(_onSendMessage);

  //   on(_receivedMessage);

  //   on(_onSelectImage);

  //   on(_updateOrAddMessage);

  //   on(_toggleSendSticker);

  //   on(_toggleHasFocus);

  //   on(_onSendSticker);

  //   on(_onKeyboardVisible);

  //   on(_onShowStickerBoard);

  //   on(_onSaveRecord);

  //   on(_onSelectVideo);

  //   on(_onSelectAudio);

  //   on(_onSelectDocument);

  //   on(_onSendSuccessMessage);

  //   on(_onSaveShowAttachSelection);

  //   on(_sendFileBackgroundMessage);

  //   on(_onSelectCurrentLocation);

  //   on(_onSelectLocation);
  // }

  Future<void> _loadRoomInfo() async {
    // if (state.roomInfo == null) {
    //   final res = await _chatRepository.findRoomById(roomId);

    //   res.map((right) {
    //     emit(state.copyWith(roomInfo: right));
    //   });
    // }
  }

  Future<void> _loadMessages() async {
    // final res = await _chatRepository.getMessages(id: roomId, page: page);

    // res.map((right) {
    //   page++;
    //   if (right != null) {
    //     _handleResponseMessageData(right);

    //     hasMore = right.length >= 20;
    //   }
    // });
  }

  void _handleResponseMessageData(List<MessageModel> value) {
    final PriorityQueue<MessageModel> data = PriorityQueue<MessageModel>(
        (p0, p1) => p1.createdAt.millisecondsSinceEpoch
            .compareTo(p0.createdAt.millisecondsSinceEpoch));

    final oldMessage = [...messages];

    value.forEach((e) {
      oldMessage.removeWhere((element) => element.sId == e.sId);
    });

    data.addAll([...oldMessage, ...value]);

    _messages(data.toList());
  }

  void sendMessage() {
    if (messageInput.text.trim().isNotEmpty) {
      final content = messageInput.text;
      messageInput.clear();

      // _onSendMessage(content: content);
    }
  }

  // Future<void> _onSendMessage({
  //   final String? content,
  //   final File? image,
  //   final File? audio,
  //   final String? sticker,
  // }) async {
  //   // final res = await _chatRepository.sendMessage(
  //   //   roomId,
  //   //   content,
  //   //   image: image,
  //   //   audio: audio,
  //   //   sticker: sticker,
  //   // );

  //   // res.map((right) {
  //   //   if (right != null) {
  //   //     _handleResponseMessageData([right]);
  //   //   }
  //   // });
  // }

  // Future<void> _onSendSticker(
  //     SendStickerMessageEvent event, MessagesEmitter emit) async {
  //   add(SendMessageEvent(roomId: roomId, sticker: event.filePath));
  // }

  // Future<void> _onSelectImage(
  //     SelectImageMessagesEvent event, MessagesEmitter emit) async {
  //   final file = await pickImage();

  //   if (file != null) {
  //     add(SendFileBackgroundMessagesEvent(file, 'image'));
  //   }
  // }

  // Future<void> _onSelectVideo(
  //     SelectVideoMessagesEvent event, MessagesEmitter emit) async {
  //   final file = await pickVideoFromGallery();

  //   if (file != null) {
  //     add(SendFileBackgroundMessagesEvent(file, 'video'));
  //   }
  // }

  // Future<void> _onSelectAudio(
  //     SelectAudioMessagesEvent event, MessagesEmitter emit) async {
  //   final files = await pickFile(FileType.audio);

  //   final file = files?.firstOrNull;

  //   if (file != null) {
  //     add(SendFileBackgroundMessagesEvent(file, 'audio'));
  //   }
  // }

  // Future<void> _onSelectDocument(
  //     SelectDocumentMessagesEvent event, MessagesEmitter emit) async {
  //   final files = await pickFile(FileType.any);

  //   final file = files?.firstOrNull;

  //   if (file != null) {
  //     add(SendFileBackgroundMessagesEvent(
  //         file, Utils.getFileType(file.path) ?? 'file'));
  //   }
  // }

  // void _sendFileBackgroundMessage(
  //     SendFileBackgroundMessagesEvent event, MessagesEmitter emit) {
  //   final newMessage = BackgroundUploader().startSendMessageWithFile(
  //     roomId,
  //     null,
  //     event.file,
  //     'users/$roomId/posts',
  //     event.fileType,
  //   );

  //   emit(state.copyWith(
  //       messages: [newMessage, ...state.messages], showAttachSelection: false));

  //   final sendingInfo = BackgroundUploader().getSendingMessage(newMessage.sId);

  //   if (sendingInfo != null) {
  //     add(SendingMessagesEvent(sendingInfo, newMessage.sId));
  //   }
  // }

  // Future<void> _onSendSuccessMessage(
  //     SendingMessagesEvent event, MessagesEmitter emit) async {
  //   final prev = [...state.messages];

  //   final message = await event.info.message.future;

  //   prev.removeWhere((element) => element.sId == event.sendingId);

  //   if (message != null) {
  //     emit(state.copyWith(messages: [message, ...prev]));
  //   }
  // }

  // Future<void> _toggleSendSticker(
  //     ToggleSendStickerMessagesEvent event, MessagesEmitter emit) async {
  //   if (!state.isSendSticker) {
  //     SystemChannels.textInput.invokeMethod('TextInput.hide');
  //   } else if (messageInputFocusNode.hasFocus) {
  //     SystemChannels.textInput.invokeMethod('TextInput.show');
  //   }

  //   emit(state.copyWith(isSendSticker: !state.isSendSticker));

  //   _debouncer.debouncing(
  //     fn: () => add(StickerShowMessagesEvent(visibleSticker)),
  //     waitForMs: 100,
  //   );
  // }

  // void _onKeyboardVisible(
  //     KeyboardShowMessagesEvent event, MessagesEmitter emit) {
  //   emit(state.copyWith(isKeyboardVisible: event.isKeyboardVisible));

  //   _debouncer.debouncing(
  //     fn: () => add(StickerShowMessagesEvent(visibleSticker)),
  //     waitForMs: 100,
  //   );
  // }

  // void _onShowStickerBoard(
  //     StickerShowMessagesEvent event, MessagesEmitter emit) {
  //   emit(state.copyWith(visibleSticker: event.isShow));
  // }

  // void _onSaveRecord(SaveRecordAudioMessagesEvent event, MessagesEmitter emit) {
  //   if (event.audio != null) {
  //     add(SendFileBackgroundMessagesEvent(event.audio!, 'audio'));
  //   }
  // }

  // void _onSaveShowAttachSelection(
  //     ShowAttachSelectionMessagesEvent event, MessagesEmitter emit) {
  //   emit(state.copyWith(showAttachSelection: event.show));
  // }

  @override
  void onClose() {
    messageInput.dispose();
    messageInputFocusNode.dispose();
    super.onClose();
  }
}
