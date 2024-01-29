import 'package:json_annotation/json_annotation.dart';

part 'doctor_data.g.dart';

@JsonSerializable()
class DoctorData {
  final int id;
  String? name;
  int? experence;
  String? degree;
  String? describe;
  String? fields;
  String? avatar;

  DoctorData(this.id);

  factory DoctorData.fromJson(Map<String, dynamic> json) =>
      _$DoctorDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDataToJson(this);
}
