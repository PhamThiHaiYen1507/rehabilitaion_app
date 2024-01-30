// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      id: json['id'] as int?,
    )
      ..createAt = json['createAt'] as String?
      ..content = json['content'] as String?
      ..isDoctor = json['isDoctor'] as bool?;

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt,
      'content': instance.content,
      'isDoctor': instance.isDoctor,
    };

MessageFile _$MessageFileFromJson(Map<String, dynamic> json) => MessageFile()
  ..postFileName = json['post_file_name'] as String?
  ..postFileType = json['post_file_type'] as String?
  ..postFilePath = json['post_file_path'] as String?;

Map<String, dynamic> _$MessageFileToJson(MessageFile instance) =>
    <String, dynamic>{
      'post_file_name': instance.postFileName,
      'post_file_type': instance.postFileType,
      'post_file_path': instance.postFilePath,
    };
