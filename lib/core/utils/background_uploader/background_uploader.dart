// import 'dart:async';
// import 'dart:io';

// import 'package:finplus/core/typedef/queue_task.dart';
// import 'package:finplus/layers/domain/entities/message_model.dart';
// import 'package:finplus/layers/domain/repository/chat_repository.dart';

// class SendingMessageInfo {
//   final MessageModel sendingInfo;
//   final Completer<MessageModel?> message;
//   final StreamController<num> stream;

//   SendingMessageInfo(this.message, this.stream, this.sendingInfo);
// }

// typedef UploadFunction = void Function(num percent);

// class BackgroundUploader {
//   static final BackgroundUploader _instance = BackgroundUploader._();

//   // final FileProvider _fileProvider = FileProvider();

//   late final List repos;

//   final FutureTaskQueue<MessageModel?> _queue = FutureTaskQueue();

//   final Map<String, SendingMessageInfo> _info = {};

//   factory BackgroundUploader() {
//     return _instance;
//   }

//   BackgroundUploader._();

//   void setRepository(List repos) {
//     this.repos = repos;
//   }

//   MessageModel startSendMessageWithFile(
//     String roomId,
//     String? content,
//     File file,
//     String serverFolder,
//     String fileType,
//   ) {
//     final newMessage = MessageModel.randomId(roomId, 'userId');

//     _queue.add(
//       () => _sendFile(roomId, content, newMessage.id.toString(), file,
//           serverFolder, fileType, newMessage),
//       newMessage.id.toString(),
//     );

//     return newMessage;
//   }

//   Future<MessageModel?> _sendFile(
//     String roomId,
//     String? content,
//     String id,
//     File file,
//     String serverFolder,
//     String fileType,
//     MessageModel sendingInfo,
//   ) async {
//     final StreamController<num> streamController = StreamController.broadcast();

//     _info[id] = SendingMessageInfo(
//         Completer<MessageModel?>(), streamController, sendingInfo);

//     // final fileData =
//     //     await _fileProvider.uploadFileWithStream(file, serverFolder, (percent) {
//     //   streamController.sink.add(percent);
//     // });

//     streamController.close();

//     // final res = await _chatRepository.sendMessageWithFileData(
//     //   roomId,
//     //   content,
//     //   fileType: fileType,
//     // );

//     const res = null;
//     return res?.fold((left) => null, (right) {
//       _info[id]?.message.complete(right);
//       _info.remove(id);
//       return right;
//     });
//   }

//   // List<MessageModel> getSendingMessageWithRoomId(int roomId) => _info.entries
//   //     .where((element) => element.value.sendingInfo.roomId == roomId)
//   //     .map((e) => e.value.sendingInfo)
//   //     .toList();

//   SendingMessageInfo? getSendingMessage(String id) => _info[id];

//   ChatRepository get _chatRepository => repos.whereType<ChatRepository>().first;
// }
