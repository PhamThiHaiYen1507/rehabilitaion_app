import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/message_model.dart';
import '../../domain/entities/message_place_model.dart';
import 'user_data.dart';

part 'message_data.g.dart';

@JsonSerializable()
class MessageData {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'owner_id')
  final String ownerId;

  final String? createdAt;

  String? updatedAt;

  @JsonKey(name: 'post_content')
  String? postContent;

  @JsonKey(name: 'file_main')
  MessageFile? fileMain;

  @JsonKey(name: 'post_plugins')
  List<String?>? postPlugins;

  @JsonKey(name: 'post_files')
  List<MessageFile>? postFiles;

  @JsonKey(name: 'post_place')
  Map<String, dynamic>? messagePlace;

  @JsonKey(name: 'owner_profile')
  final UserData? ownerProfile;

  MessageData({
    required this.id,
    required this.userId,
    required this.ownerId,
    this.createdAt,
    this.fileMain,
    this.ownerProfile,
  });

  bool get isSticker => postPlugins?.contains('sticker') ?? false;

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);

  MessageModel toMessagesModel() {
    MessagePlaceModel? place;

    if (messagePlace is Map &&
        messagePlace!.containsKey('geometry') &&
        (messagePlace!['geometry'] as Map)['location'] is Map) {
      try {
        final lat = (messagePlace!['geometry'] as Map)['location']['lat'];
        final lng = (messagePlace!['geometry'] as Map)['location']['lng'];

        if (lat is num && lng is num) {
          place = MessagePlaceModel(
            latitude: lat,
            longitude: lng,
            name: messagePlace?['name'] ?? '',
          );
        }
      } catch (_) {}
    }

    return MessageModel(
        id: id,
        roomId: userId,
        createdAt: DateTime.tryParse(createdAt ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(updatedAt ?? ''),
        message: postContent ?? '',
        userId: ownerId,
        fileMain: fileMain?.postFilePath,
        files: [
          if (fileMain?.postFilePath != null) fileMain!.postFilePath!,
          if (postFiles != null && fileMain == null)
            ...postFiles!
                .where((element) => element.postFilePath?.isNotEmpty == true)
                .map((e) => e.postFilePath!)
                .toList()
        ],
        fileTypes: postPlugins?.whereType<String>().toList() ?? [],
        place: place,
        user: ownerProfile?.toUserModel());
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
