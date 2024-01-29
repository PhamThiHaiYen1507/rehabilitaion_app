// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_owner_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomOwnerData _$RoomOwnerDataFromJson(Map<String, dynamic> json) =>
    RoomOwnerData()
      ..sId = json['_id'] as String?
      ..fullName = json['full_name'] as String?
      ..objectType = json['object_type'] as String?
      ..email = json['email'] as String?
      ..phone = json['phone'] as String?
      ..updatedAt = json['updatedAt'] as String?
      ..avatar = json['avatar'] as String?
      ..id = json['id'] as String?;

Map<String, dynamic> _$RoomOwnerDataToJson(RoomOwnerData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'full_name': instance.fullName,
      'object_type': instance.objectType,
      'email': instance.email,
      'phone': instance.phone,
      'updatedAt': instance.updatedAt,
      'avatar': instance.avatar,
      'id': instance.id,
    };
