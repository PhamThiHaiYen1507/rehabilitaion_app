import 'package:json_annotation/json_annotation.dart';

part 'room_owner_data.g.dart';

@JsonSerializable()
class RoomOwnerData {
  @JsonKey(name: '_id')
  String? sId;

  @JsonKey(name: 'full_name')
  String? fullName;

  @JsonKey(name: 'object_type')
  String? objectType;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'id')
  String? id;

  RoomOwnerData();

  factory RoomOwnerData.fromJson(Map<String, dynamic> json) =>
      _$RoomOwnerDataFromJson(json);

  Map<String, dynamic> toJson() => _$RoomOwnerDataToJson(this);
}
