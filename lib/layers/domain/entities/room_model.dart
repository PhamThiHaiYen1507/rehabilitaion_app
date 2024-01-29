// ignore_for_file: unused_import
import 'package:floor_annotation/floor_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message_model.dart';
import 'user_model.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  @primaryKey
  final String id;

  final String createdById;

  final DateTime createdAt;

  final DateTime updatedAt;

  MessageModel? lastMessage;

  String? name;

  int countMessagesUnseen;

  String? avatar;

  final bool isGroup;

  final List<UserModel> users;

  RoomModel({
    required this.id,
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
    this.avatar,
    required this.countMessagesUnseen,
    this.lastMessage,
    required this.name,
    required this.isGroup,
  });

  factory RoomModel.fromJson(dynamic json) => _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
