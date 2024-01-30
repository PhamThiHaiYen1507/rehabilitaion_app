import 'package:json_annotation/json_annotation.dart';

part 'send_message_request.g.dart';

@JsonSerializable()
class SendMessageRequest {
  final Map<String, dynamic> chatRoom;

  final String content;

  final bool isDoctor;

  SendMessageRequest({
    required this.chatRoom,
    required this.content,
    required this.isDoctor,
  });

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
