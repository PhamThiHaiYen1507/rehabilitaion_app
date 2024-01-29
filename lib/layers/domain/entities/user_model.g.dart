// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      avatar: json['avatar'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      isDoctor: json['isDoctor'] as bool? ?? false,
    )
      ..doctorInfo = json['doctorInfo'] == null
          ? null
          : DoctorData.fromJson(json['doctorInfo'] as Map<String, dynamic>)
      ..patientInfo = json['patientInfo'] == null
          ? null
          : PatientData.fromJson(json['patientInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'phoneNumber': instance.phoneNumber,
      'isDoctor': instance.isDoctor,
      'doctorInfo': instance.doctorInfo,
      'patientInfo': instance.patientInfo,
    };
