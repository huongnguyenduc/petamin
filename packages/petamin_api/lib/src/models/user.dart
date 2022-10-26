import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(includeIfNull: false)
class User {
  User({
    this.name = "",
    this.avatar = "",
    this.address = "",
    this.phone = "",
    this.bio = "",
    this.gender = "",
    this.email = "",
    this.birthday = "",
  });

  String? name;
  String? avatar;
  String? address;
  String? phone;
  String? bio;
  String? gender;
  String? email;
  String? birthday;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
