import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  Profile(
      {this.name,
      this.avatar,
      this.address,
      this.phone,
      this.description,
      this.gender,
      this.birthday,
      this.email,
      this.userId,
      this.profileId});

  String? email;
  String? name;
  String? avatar;
  String? address;
  String? phone;
  String? description;
  String? gender;
  String? birthday;
  String? userId;
  String? profileId;

  // empty profile
  Profile.empty()
      :  this(
            name: '',
            avatar: '',
            address: '',
            phone: '',
            description: '',
            gender: '',
            birthday: '',
            email: '',
            userId: '',
            profileId: '');
  @override
  List<Object?> get props => [
        avatar,
        address,
        phone,
        description,
        email,
        name,
        birthday,
        userId,
        profileId
      ];

  Profile copyWith({
    String? avatar,
    String? address,
    String? phone,
    String? description,
    String? gender,
    String? birthday,
    String? userId,
    String? name,
    String? email,
    String? profileId,
  }) =>
      Profile(
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        description: description ?? this.description,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        email: email ?? this.email,
        userId: userId ?? this.userId,
        profileId: profileId ?? this.profileId,
      );

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
