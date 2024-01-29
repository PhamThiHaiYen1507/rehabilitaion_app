// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomData _$RoomDataFromJson(Map<String, dynamic> json) => RoomData(
      id: json['id'] as int,
      createdAt: json['createdAt'] as String?,
      patient: json['patient'] == null
          ? null
          : PatientData.fromJson(json['patient'] as Map<String, dynamic>),
      doctor: json['doctor'] == null
          ? null
          : DoctorData.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomDataToJson(RoomData instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'patient': instance.patient,
      'doctor': instance.doctor,
    };
