import 'package:json_annotation/json_annotation.dart';

part 'chat_profile.g.dart';

@JsonSerializable()
class ChatProfile {
  ChatProfile({
    required this.id,
    required this.name,
    this.avatar,
    this.address,
    this.phone,
    this.bio,
    this.gender,
    this.birthday,
    required this.totalFollowers,
    required this.totalFollowings,
  });

  String id;
  String name;
  String? avatar;
  String? address;
  String? phone;
  String? bio;
  String? gender;
  String? birthday;
  int totalFollowers;
  int totalFollowings;

  factory ChatProfile.fromJson(Map<String, dynamic> json) => _$ChatProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ChatProfileToJson(this);
}
