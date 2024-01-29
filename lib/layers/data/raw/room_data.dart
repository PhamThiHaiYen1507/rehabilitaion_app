import 'package:finplus/layers/data/raw/patient_data.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/room_model.dart';
import 'doctor_data.dart';

part 'room_data.g.dart';

@JsonSerializable()
class RoomData {
  RoomData({
    required this.id,
    required this.createdAt,
    this.patient,
    this.doctor,
  });

  final int id;

  final String? createdAt;

  final PatientData? patient;

  final DoctorData? doctor;

  Map<String, dynamic> toJson() => _$RoomDataToJson(this);

  factory RoomData.fromJson(Map<String, dynamic> json) =>
      _$RoomDataFromJson(json);

  RoomModel toRoomModel(bool isDoctor) => RoomModel(
        id: id,
        createdAt: createdAt ?? '',
        name: isDoctor ? (patient?.name ?? '') : (doctor?.name ?? ''),
        avatar: isDoctor ? (patient?.avatar ?? '') : (doctor?.avatar ?? ''),
      );
}
