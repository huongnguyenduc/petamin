import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'chat_user.g.dart';

@JsonSerializable()
class ChatUser {
  ChatUser({
    required this.id,
    required this.email,
    required this.profile,
  });

  String id;
  String email;
  ChatProfile profile;

  factory ChatUser.fromJson(Map<String, dynamic> json) => _$ChatUserFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserToJson(this);
}
