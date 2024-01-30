import 'dart:async';

import 'package:commons/commons.dart';
import 'package:either_dart/either.dart';
import 'package:finplus/core/extensions/extensions.dart';
import 'package:finplus/core/response/base_response.dart';
import 'package:finplus/core/typedef/typedef.dart';
import 'package:finplus/layers/data/source/api/api_client.dart';
import 'package:finplus/layers/domain/entities/room_model.dart';
import 'package:finplus/layers/domain/entities/user_model.dart';
import 'package:finplus/utils/app_logger.dart';

import '../../../core/exceptions/api_exception.dart';
import '../../../utils/types.dart';
import '../../domain/entities/message_model.dart';
import '../../domain/repository/chat_repository.dart';
import '../raw/message_data.dart';
import '../raw/room_data.dart';
import '../requests/send_message_request.dart';

class ChatRepositoryImpl extends ChatRepository {
  // final FileProvider _fileProvider = FileProvider();

  final ApiClient _client = ApiClientImpl();

  // @override
  // Future<ApiResponseData<RoomModel?>> createRoom({dynamic params}) async {
  //   try {
  //     final res = await _client.createRoom(params);
  //     final room = res.getBody(RoomData.fromJson, fromKey: 'data');

  //     if (room != null) {
  //       return Right(room.toRoomModel());
  //     } else {
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     return Left(ApiException());
  //   }
  // }

  @override
  Future<ApiResponseData<List<RoomModel>?>> getRooms({
    required UserModel user,
  }) async {
    try {
      final BaseResponse res;

      if (user.isDoctor) {
        res = await _client.getDoctorRooms(user.doctorInfo?.id ?? -1);
      } else {
        res = await _client.getPatientRooms(user.patientInfo?.id ?? -1);
      }

      final rooms = res.getItems(RoomData.fromJson)?.map<RoomModel>((e) {
            return e.toRoomModel(user.isDoctor);
          }).toList() ??
          [];

      return Right(rooms);
    } on Exception catch (e) {
      logE(e);
      // if (page == 1) {
      return Left(ApiException());
      // }

      // return Left(ApiException());
    }
  }

  @override
  Future<ApiResponseData<List<MessageModel>?>> getMessages({
    required int roomId,
  }) async {
    try {
      final res = await _client.getMessages(roomId);

      final data = res
          .getItems(MessageData.fromJson)
          ?.map<MessageModel>((e) => e.toMessagesModel())
          .toList();

      return Right(data);
    } on Exception {
      Left(ApiException());

      return Left(ApiException());
    }
  }

  // @override
  // Future<ApiResponseData<RoomModel?>> findRoomById(String id) async {
  //   // try {
  //   final res = await _chatDataBase.findRoomById(id);

  //   return Right(res);
  //   // } catch (e) {
  //   //   return Left(ApiException());
  //   // }
  // }

  @override
  Future<ApiResponseData<MessageModel>> sendMessage(
    int roomId,
    String? content, {
    bool? isDoctor,
  }) async {
    try {
      final res = await _client.sendMessage(SendMessageRequest(
        content: content ?? '',
        isDoctor: isDoctor ?? false,
        chatRoom: {'id': roomId},
      ));

      final data = res.getBody(MessageData.fromJson);

      return Right(data!.toMessagesModel());
    } catch (e) {
      return Left(ApiException());
    }
  }

  // @override
  // Future<ApiResponseData<MessageModel>> sendMessageWithFileData(
  //     String roomId, String? content, FileData fileData,
  //     {String? fileType}) async {
  //   try {
  //     final res = await _client.sendMessage(SendMessageRequest(
  //       roomId: roomId,
  //       content: content,
  //       fileMain: fileData.toJson(),
  //       fileTypes: fileType != null
  //           ? [fileType]
  //           : [
  //               if (fileData.mimetype.contains('sticker')) 'sticker',
  //               if (fileData.mimetype.contains('audio')) 'audio',
  //               if (fileData.mimetype.contains('image')) 'image',
  //             ],
  //     ));

  //     final data = res.getBody(MessageData.fromJson);

  //     return Right(data!.toMessagesModel());
  //   } catch (e) {
  //     return Left(ApiException());
  //   }
  // }

  @override
  Future<ApiResponseData<List<MessageModel>?>> getMessagesFromLastMessage(
      {required String id, required DateTime time}) async {
    try {
      final res =
          await _client.getMessagesFromLastMessage(id, time.toIso8601String());

      final data = res
          .getItems(MessageData.fromJson)
          ?.map<MessageModel>((e) => e.toMessagesModel())
          .toList();

      return Right(data);
    } on Exception {
      return Left(ApiException());
    }
  }

  @override
  UserModel? getUserFromStorage() {
    return Storage.get(KEY.LOGIN_DATA, UserModel.fromJson);
  }
}
