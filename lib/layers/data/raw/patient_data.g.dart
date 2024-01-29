// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientData _$PatientDataFromJson(Map<String, dynamic> json) => PatientData(
      json['id'] as int,
    )
      ..name = json['name'] as String?
      ..phoneNumber = json['phoneNumber'] as String?
      ..address = json['address'] as String?
      ..birthday = json['birthday'] as String?
      ..avatar = json['avatar'] as String?
      ..userId = json['userId'] as int?
      ..gender = json['gender'] as String?;

Map<String, dynamic> _$PatientDataToJson(PatientData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'birthday': instance.birthday,
      'avatar': instance.avatar,
      'userId': instance.userId,
      'gender': instance.gender,
    };
