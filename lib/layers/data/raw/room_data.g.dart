// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomData _$RoomDataFromJson(Map<String, dynamic> json) => RoomData(
      sId: json['_id'] as String?,
    )
      ..userChatId = json['user_chat_id'] as String?
      ..type = json['type'] as String?
      ..createdById = json['createdById'] as String?
      ..createdAt = json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String)
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String)
      ..userChat = json['user_chat'] == null
          ? null
          : RoomInfoData.fromJson(json['user_chat'] as Map<String, dynamic>)
      ..lastMessage = json['lastMessage'] == null
          ? null
          : MessageData.fromJson(json['lastMessage'] as Map<String, dynamic>)
      ..countMessagesUnseen = json['countMessagesUnseen'] as int?
      ..owner = json['owner'] == null
          ? null
          : RoomOwnerData.fromJson(json['owner'] as Map<String, dynamic>)
      ..toData = json['to'] == null
          ? null
          : RoomOwnerData.fromJson(json['to'] as Map<String, dynamic>);

Map<String, dynamic> _$RoomDataToJson(RoomData instance) => <String, dynamic>{
      '_id': instance.sId,
      'user_chat_id': instance.userChatId,
      'type': instance.type,
      'createdById': instance.createdById,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'user_chat': instance.userChat,
      'lastMessage': instance.lastMessage,
      'countMessagesUnseen': instance.countMessagesUnseen,
      'owner': instance.owner,
      'to': instance.toData,
    };
