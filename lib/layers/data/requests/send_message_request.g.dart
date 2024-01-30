// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) =>
    SendMessageRequest(
      chatRoom: json['chatRoom'] as Map<String, dynamic>,
      content: json['content'] as String,
      isDoctor: json['isDoctor'] as bool,
    );

Map<String, dynamic> _$SendMessageRequestToJson(SendMessageRequest instance) =>
    <String, dynamic>{
      'chatRoom': instance.chatRoom,
      'content': instance.content,
      'isDoctor': instance.isDoctor,
    };
