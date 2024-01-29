// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagePlaceModel _$MessagePlaceModelFromJson(Map<String, dynamic> json) =>
    MessagePlaceModel(
      latitude: json['latitude'] as num,
      longitude: json['longitude'] as num,
      name: json['name'] as String,
    );

Map<String, dynamic> _$MessagePlaceModelToJson(MessagePlaceModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
    };
