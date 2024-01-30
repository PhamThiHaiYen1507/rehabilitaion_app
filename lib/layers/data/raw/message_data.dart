import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/message_model.dart';

part 'message_data.g.dart';

@JsonSerializable()
class MessageData {
  int? id;
  String? createAt;
  String? content;
  bool? isDoctor;

  MessageData({
    required this.id,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);

  MessageModel toMessagesModel() {
    return MessageModel(
      id: id ?? -1,
      createdAt: DateTime.tryParse(createAt ?? '') ?? DateTime.now(),
      content: content ?? '',
      isDoctor: isDoctor ?? false,
    );
  }
}

@JsonSerializable()
class MessageFile {
  @JsonKey(name: 'post_file_name')
  String? postFileName;

  @JsonKey(name: 'post_file_type')
  String? postFileType;

  @JsonKey(name: 'post_file_path')
  String? postFilePath;

  MessageFile();

  factory MessageFile.fromJson(Map<String, dynamic> json) =>
      _$MessageFileFromJson(json);

  Map<String, dynamic> toJson() => _$MessageFileToJson(this);
}
