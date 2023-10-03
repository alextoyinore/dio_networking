import 'package:json_annotation/json_annotation.dart';

part 'userinfo.g.dart';

@JsonSerializable()
class UserInfo {
  String? name;
  String? job;
  String? id;
  String? createdAt;
  String? updatedAt;

  UserInfo({
    this.name,
    this.job,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo copyWith({
    String? name,
    String? job,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserInfo(
      name: name ?? this.name,
      job: job ?? this.job,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
