import 'package:html/parser.dart' show parse;
import 'package:json_annotation/json_annotation.dart';

import 'message_place_model.dart';
import 'user_model.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  late final int id;

  late final String roomId;

  late final DateTime createdAt;

  late final DateTime? updatedAt;

  late final String message;

  late final String userId;

  late final List<String> files;

  late final String? fileMain;

  late final List<String> fileTypes;

  late final MessagePlaceModel? place;

  final UserModel? user;

  bool get isSticker => fileTypes.contains('sticker');

  bool get isAudio => fileTypes.contains('audio');

  bool get isVideo => fileTypes.contains('video');

  bool get isImage => fileTypes.contains('image') && !isSticker;

  bool get isLocation => place != null;

  bool get isContentEmpty {
    final data = parse(message);

    if (data.text == null) {
      return message.isEmpty;
    }

    return data.text?.isNotEmpty != true;
  }

  bool get onlyMedia => files.isNotEmpty && isContentEmpty;

  bool get isSending => false;

  MessageModel({
    required this.id,
    required this.roomId,
    required this.createdAt,
    this.updatedAt,
    this.fileMain,
    required this.message,
    required this.userId,
    required this.files,
    required this.fileTypes,
    required this.place,
    this.user,
  });

  MessageModel.randomId(this.roomId, this.userId, [this.user]) {
    id = 0;
    createdAt = DateTime.now();
    updatedAt = null;
    fileMain = null;
    message = '';
    files = [];
    fileTypes = [];
    place = null;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
