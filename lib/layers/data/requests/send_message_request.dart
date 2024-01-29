import 'package:json_annotation/json_annotation.dart';

part 'send_message_request.g.dart';

@JsonSerializable()
class SendMessageRequest {
  @JsonKey(name: 'being_posted_user_id')
  final String roomId;

  @JsonKey(name: 'post_content')
  String? content;

  @JsonKey(name: 'post_plugins')
  List<String?> fileTypes;

  final List fileList;

  @JsonKey(name: 'file_main')
  final Map<String, dynamic>? fileMain;

  @JsonKey(name: 'post_place')
  final Map<String, dynamic>? messagePlace;

  SendMessageRequest({
    required this.roomId,
    required this.content,
    this.fileMain,
    this.fileList = const [],
    this.fileTypes = const [],
    this.messagePlace,
  });

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => {
        ..._$SendMessageRequestToJson(this),
        'ref_type': 'message',
        'post_privacy': 'public',
        'feed_type': 'normal',
      };
}
