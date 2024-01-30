import 'dart:async';

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
    required int roomId,
    // int page = 1,
    // int limit = 20,
  });

  Future<ApiResponseData<List<MessageModel>?>> getMessagesFromLastMessage(
      {required String id, required DateTime time});

  Future<ApiResponseData<MessageModel>> sendMessage(
    int roomId,
    String? content, {
    bool? isDoctor,
  });

  UserModel? getUserFromStorage();
}
