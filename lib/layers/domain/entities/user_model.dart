import 'package:json_annotation/json_annotation.dart';

import '../../data/raw/doctor_data.dart';
import '../../data/raw/patient_data.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;

  final String username;

  String? avatar;

  final String phoneNumber;

  bool isDoctor;

  DoctorData? doctorInfo;

  PatientData? patientInfo;

  UserModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.phoneNumber,
    this.isDoctor = false,
  });

  factory UserModel.fromJson(dynamic json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
