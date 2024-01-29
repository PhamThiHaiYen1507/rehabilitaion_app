import 'package:json_annotation/json_annotation.dart';

part 'room_info_data.g.dart';

@JsonSerializable()
class RoomInfoData {
  @JsonKey(name: '_id')
  String? sId;

  @JsonKey(name: 'owner_id')
  String? ownerId;

  @JsonKey(name: 'full_name')
  String? fullName;

  @JsonKey(name: 'object_type')
  String? objectType;

  @JsonKey(name: 'is_sos')
  bool? isSos;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;

  @JsonKey(name: 'id')
  String? id;

  RoomInfoData();

  factory RoomInfoData.fromJson(Map<String, dynamic> json) =>
      _$RoomInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$RoomInfoDataToJson(this);
}
