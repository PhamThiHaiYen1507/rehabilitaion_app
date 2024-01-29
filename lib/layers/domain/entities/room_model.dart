// ignore_for_file: unused_import
import 'package:finplus/layers/data/raw/doctor_data.dart';
import 'package:finplus/layers/data/raw/patient_data.dart';
import 'package:floor_annotation/floor_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message_model.dart';
import 'user_model.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final int id;

  final String createdAt;

  final String name;

  final String avatar;

  bool isDoctor = false;

  RoomModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  factory RoomModel.fromJson(dynamic json) => _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
