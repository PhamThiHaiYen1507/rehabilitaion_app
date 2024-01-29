import 'dart:async';
import 'dart:io';

import '../../../core/typedef/typedef.dart';
import '../entities/message_model.dart';
import '../entities/room_model.dart';
import '../entities/user_model.dart';

abstract class ChatRepository {
  Future<ApiResponseData<List<RoomModel>?>> getRooms({
    required UserModel user,
  });

  // Future<ApiResponseData<RoomModel?>> createRoom({dynamic params});

  Future<ApiResponseData<List<MessageModel>?>> getMessages({
    required String id,
    int page = 1,
    int limit = 20,
  });

  Future<ApiResponseData<List<MessageModel>?>> getMessagesFromLastMessage(
      {required String id, required DateTime time});

  Future<ApiResponseData<MessageModel>> sendMessage(
    String roomId,
    String? content, {
    File? image,
    File? audio,
    String? sticker,
    String? locationName,
  });

  UserModel? getUserFromStorage();
}
