import 'package:json_annotation/json_annotation.dart';

part 'patient_data.g.dart';

@JsonSerializable()
class PatientData {
  PatientData(this.id);

  final int id;

  String? name;

  String? phoneNumber;

  String? address;

  String? birthday;

  String? avatar;

  int? userId;

  String? gender;

  factory PatientData.fromJson(Map<String, dynamic> json) =>
      _$PatientDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDataToJson(this);
}
