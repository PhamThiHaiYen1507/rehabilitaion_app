// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      id: json['id'] as int,
      userId: '',
      ownerId: '',
      createdAt: json['createdAt'] as String?,
      fileMain: json['file_main'] == null
          ? null
          : MessageFile.fromJson(json['file_main'] as Map<String, dynamic>),
      ownerProfile: json['owner_profile'] == null
          ? null
          : UserData.fromJson(json['owner_profile'] as Map<String, dynamic>),
    )
      ..updatedAt = json['updatedAt'] as String?
      ..postContent = json['post_content'] as String?
      ..postPlugins = (json['post_plugins'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList()
      ..postFiles = (json['post_files'] as List<dynamic>?)
          ?.map((e) => MessageFile.fromJson(e as Map<String, dynamic>))
          .toList()
      ..messagePlace = json['post_place'] as Map<String, dynamic>?;

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'owner_id': instance.ownerId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'post_content': instance.postContent,
      'file_main': instance.fileMain,
      'post_plugins': instance.postPlugins,
      'post_files': instance.postFiles,
      'post_place': instance.messagePlace,
      'owner_profile': instance.ownerProfile,
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
