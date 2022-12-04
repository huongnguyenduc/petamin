import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  const Profile(
      {this.name,
      this.avatar = 'https://petamin.s3.ap-southeast-1.amazonaws.com/3faf67c28e038599927d1d3d09a539b8.png',
      this.address,
      this.phone,
      this.description,
      this.gender,
      this.birthday,
      this.email,
      this.userId,
      this.profileId,
      this.followers,
      this.followings,
      this.isFollow = false,
      this.pets = const [],
      this.adoptions = const []});

  final String? email;
  final String? name;
  final String? avatar;
  final String? address;
  final String? phone;
  final String? description;
  final String? gender;
  final String? birthday;
  final String? userId;
  final String? profileId;
  final int? followers;
  final int? followings;
  final bool? isFollow;
  final List<Pet>? pets;
  final List<Adopt>? adoptions;

  static const empty = Profile(
      name: '',
      avatar: '',
      address: '',
      phone: '',
      description: '',
      gender: '',
      birthday: '',
      email: '',
      userId: '',
      profileId: '',
      followers: 0,
      followings: 0,
      isFollow: false,
      pets: [],
      adoptions: []);

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
        profileId,
        followers,
        followings,
        isFollow,
        pets,
        adoptions
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
    int? followers,
    int? followings,
    bool? isFollow,
    List<Pet>? pets,
    List<Adopt>? adoptions,
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
        followers: followers ?? this.followers,
        followings: followings ?? this.followings,
        isFollow: isFollow ?? this.isFollow,
        pets: pets ?? this.pets,
        adoptions: adoptions ?? this.adoptions,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
