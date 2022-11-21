// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String? ?? "",
      name: json['name'] as String? ?? "",
      avatar: json['avatar'] as String? ?? "",
      address: json['address'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      bio: json['bio'] as String? ?? "",
      gender: json['gender'] as String? ?? "",
      email: json['email'] as String? ?? "",
      birthday: json['birthday'] as String? ?? "",
      totalFollowers: json['totalFollowers'] as int? ?? 0,
      totalFollowings: json['totalFollowings'] as int? ?? 0,
      isFollow: json['isFollow'] as bool? ?? false,
      pets: (json['pets'] as List<dynamic>?)
              ?.map((e) => PetRes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )..adoptions = (json['adoptions'] as List<dynamic>?)
        ?.map((e) => Adopt.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('name', instance.name);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('address', instance.address);
  writeNotNull('phone', instance.phone);
  writeNotNull('bio', instance.bio);
  writeNotNull('gender', instance.gender);
  writeNotNull('email', instance.email);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('totalFollowers', instance.totalFollowers);
  writeNotNull('totalFollowings', instance.totalFollowings);
  writeNotNull('isFollow', instance.isFollow);
  writeNotNull('pets', instance.pets);
  writeNotNull('adoptions', instance.adoptions);
  return val;
}
