import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  late final int id;

  late final DateTime createdAt;

  late String content;

  late final bool isDoctor;

  MessageModel({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.isDoctor,
  });

  MessageModel.randomId(this.id) {
    createdAt = DateTime.now();
    content = '';
    isDoctor = false;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
