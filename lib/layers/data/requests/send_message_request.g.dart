// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) =>
    SendMessageRequest(
      roomId: json['being_posted_user_id'] as String,
      content: json['post_content'] as String?,
      fileMain: json['file_main'] as Map<String, dynamic>?,
      fileList: json['fileList'] as List<dynamic>? ?? const [],
      fileTypes: (json['post_plugins'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          const [],
      messagePlace: json['post_place'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SendMessageRequestToJson(SendMessageRequest instance) =>
    <String, dynamic>{
      'being_posted_user_id': instance.roomId,
      'post_content': instance.content,
      'post_plugins': instance.fileTypes,
      'fileList': instance.fileList,
      'file_main': instance.fileMain,
      'post_place': instance.messagePlace,
    };
