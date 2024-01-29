import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/room_model.dart';
import 'message_data.dart';
import 'room_info_data.dart';
import 'room_owner_data.dart';

part 'room_data.g.dart';

@JsonSerializable()
class RoomData {
  RoomData({this.sId});

  @JsonKey(name: '_id')
  String? sId;

  @JsonKey(name: 'user_chat_id')
  String? userChatId;

  String? type;

  String? createdById;

  DateTime? createdAt;

  DateTime? updatedAt;

  @JsonKey(name: 'user_chat')
  RoomInfoData? userChat;

  @JsonKey(name: 'lastMessage')
  MessageData? lastMessage;

  int? countMessagesUnseen;

  RoomOwnerData? owner;

  @JsonKey(name: 'to')
  RoomOwnerData? toData;

  Map<String, dynamic> toJson() => _$RoomDataToJson(this);

  factory RoomData.fromJson(Map<String, dynamic> json) =>
      _$RoomDataFromJson(json);

  RoomModel toRoomModel() => RoomModel(
        id: userChatId ?? '',
        createdById: createdById ?? '',
        createdAt: createdAt ?? DateTime.now(),
        lastMessage: lastMessage?.toMessagesModel(),
        countMessagesUnseen: countMessagesUnseen ?? 0,
        updatedAt: userChat?.updatedAt ?? updatedAt ?? DateTime.now(),
        users: [],
        name: toData?.fullName ?? owner?.fullName,
        avatar:
            toData?.avatar?.isNotEmpty == true ? toData?.avatar : owner?.avatar,
        isGroup: toData?.objectType == 'GROUP',
      );
}
