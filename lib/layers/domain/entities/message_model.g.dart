// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String,
      isDoctor: json['isDoctor'] as bool,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'content': instance.content,
      'isDoctor': instance.isDoctor,
    };
