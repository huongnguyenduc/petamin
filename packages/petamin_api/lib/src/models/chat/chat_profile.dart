import 'package:json_annotation/json_annotation.dart';

part 'chat_profile.g.dart';

@JsonSerializable(includeIfNull: false)
class ChatProfile {
  ChatProfile({
    this.id = "",
    this.name = "",
    this.avatar = "",
  });

  String? id;
  String? name;
  String? avatar;

  factory ChatProfile.fromJson(Map<String, dynamic> json) => _$ChatProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ChatProfileToJson(this);
}
