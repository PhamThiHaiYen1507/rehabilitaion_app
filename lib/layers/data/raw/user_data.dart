import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_model.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final int userId;
  String? phoneNumber;
  String? password;
  bool? isDoctor;
  String? createAt;
  String? name;

  UserData(
      {required this.userId,
      required this.phoneNumber,
      this.password,
      this.isDoctor,
      this.createAt,
      required this.name});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserModel toUserModel() {
    return UserModel(
      id: userId,
      username: name ?? '',
      avatar: null,
      phoneNumber: phoneNumber ?? '',
      isDoctor: isDoctor ?? false,
    );
  }
}
