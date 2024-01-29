// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorData _$DoctorDataFromJson(Map<String, dynamic> json) => DoctorData(
      json['id'] as int,
    )
      ..name = json['name'] as String?
      ..experence = json['experence'] as int?
      ..degree = json['degree'] as String?
      ..describe = json['describe'] as String?
      ..fields = json['fields'] as String?
      ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$DoctorDataToJson(DoctorData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'experence': instance.experence,
      'degree': instance.degree,
      'describe': instance.describe,
      'fields': instance.fields,
      'avatar': instance.avatar,
    };
