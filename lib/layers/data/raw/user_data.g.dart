// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userId: json['userId'] as int,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      isDoctor: json['isDoctor'] as bool?,
      createAt: json['createAt'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'userId': instance.userId,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'isDoctor': instance.isDoctor,
      'createAt': instance.createAt,
      'name': instance.name,
    };
