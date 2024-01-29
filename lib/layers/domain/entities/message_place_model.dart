import 'package:json_annotation/json_annotation.dart';

part 'message_place_model.g.dart';

@JsonSerializable()
class MessagePlaceModel {
  MessagePlaceModel(
      {required this.latitude, required this.longitude, required this.name});

  final num latitude;

  final num longitude;

  final String name;

  factory MessagePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$MessagePlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagePlaceModelToJson(this);
}
