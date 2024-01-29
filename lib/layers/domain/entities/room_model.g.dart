// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      id: json['id'] as int,
      createdAt: json['createdAt'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    )..isDoctor = json['isDoctor'] as bool;

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'avatar': instance.avatar,
      'isDoctor': instance.isDoctor,
    };
