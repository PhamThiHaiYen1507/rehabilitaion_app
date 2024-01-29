// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      sId: json['sId'] as String,
      roomId: json['roomId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      fileMain: json['fileMain'] as String?,
      message: json['message'] as String,
      userId: json['userId'] as String,
      files: (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      fileTypes:
          (json['fileTypes'] as List<dynamic>).map((e) => e as String).toList(),
      place: json['place'] == null
          ? null
          : MessagePlaceModel.fromJson(json['place'] as Map<String, dynamic>),
      user: json['user'] == null ? null : UserModel.fromJson(json['user']),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'sId': instance.sId,
      'roomId': instance.roomId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'message': instance.message,
      'userId': instance.userId,
      'files': instance.files,
      'fileMain': instance.fileMain,
      'fileTypes': instance.fileTypes,
      'place': instance.place,
      'user': instance.user,
    };
