// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomInfoData _$RoomInfoDataFromJson(Map<String, dynamic> json) => RoomInfoData()
  ..sId = json['_id'] as String?
  ..ownerId = json['owner_id'] as String?
  ..fullName = json['full_name'] as String?
  ..objectType = json['object_type'] as String?
  ..isSos = json['is_sos'] as bool?
  ..updatedAt = json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String)
  ..id = json['id'] as String?;

Map<String, dynamic> _$RoomInfoDataToJson(RoomInfoData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'owner_id': instance.ownerId,
      'full_name': instance.fullName,
      'object_type': instance.objectType,
      'is_sos': instance.isSos,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
    };
