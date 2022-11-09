import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'chat_user.g.dart';

@JsonSerializable(includeIfNull: false)
class ChatUser {
  ChatUser({
    this.id = "",
    this.email = "",
    this.profile,
  });

  String? id;
  String? email;
  ChatProfile? profile;

  factory ChatUser.fromJson(Map<String, dynamic> json) => _$ChatUserFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}
