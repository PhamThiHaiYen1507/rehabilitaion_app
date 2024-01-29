// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      id: json['id'] as String,
      createdById: json['createdById'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      users: (json['users'] as List<dynamic>).map(UserModel.fromJson).toList(),
      avatar: json['avatar'] as String?,
      countMessagesUnseen: json['countMessagesUnseen'] as int,
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
      name: json['name'] as String?,
      isGroup: json['isGroup'] as bool,
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdById': instance.createdById,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastMessage': instance.lastMessage,
      'name': instance.name,
      'countMessagesUnseen': instance.countMessagesUnseen,
      'avatar': instance.avatar,
      'isGroup': instance.isGroup,
      'users': instance.users,
    };
