import 'package:json_annotation/json_annotation.dart';
import 'package:petamin_api/petamin_api.dart';
part 'user.g.dart';

@JsonSerializable(includeIfNull: false)
class User {
  User({
    this.userId = "",
    this.name = "",
    this.avatar = "",
    this.address = "",
    this.phone = "",
    this.bio = "",
    this.gender = "",
    this.email = "",
    this.birthday = "",
    this.totalFollowers = 0,
    this.totalFollowings = 0,
    this.isFollow = false,
    this.pets = const [],
  });
  String? userId;
  String? name;
  String? avatar;
  String? address;
  String? phone;
  String? bio;
  String? gender;
  String? email;
  String? birthday;
  int? totalFollowers;
  int? totalFollowings;
  bool? isFollow;
  List<PetRes>? pets;
  List<Adopt>? adoptions;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
