import 'package:Petamin/shared/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:petamin_repository/petamin_repository.dart';

enum UserDetailStatus { initial, loading, success, failure }

class UserDetailState extends Equatable {
  UserDetailState({
    this.userId = '',
    this.name = '',
    this.bio = '',
    this.avatarUrl = ANONYMOUS_AVATAR,
    this.countFollowers = 0,
    this.countFollowings = 0,
    this.petList = const [],
    this.adoptList = const [],
    this.isFollow = false,
    this.status = UserDetailStatus.initial,
  });
  final int countFollowers;
  final int countFollowings;
  final String userId;
  final String name;
  final String bio;
  final String avatarUrl;
  final List<Pet> petList;
  final List<Adopt> adoptList;
  final bool isFollow;
  final UserDetailStatus status;

  @override
  List<Object> get props => [
        userId,
        name,
        bio,
        avatarUrl,
        countFollowers,
        countFollowings,
        petList,
        adoptList,
        status,
        isFollow,
      ];

  UserDetailState copyWith({
    UserDetailStatus? status,
    int? countFollowers,
    int? countFollowings,
    String? userId,
    String? name,
    String? bio,
    String? avatarUrl,
    List<Pet>? petList,
    List<Adopt>? adoptList,
    bool? isFollow,
  }) =>
      UserDetailState(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        countFollowers: countFollowers ?? this.countFollowers,
        countFollowings: countFollowings ?? this.countFollowings,
        petList: petList ?? this.petList,
        adoptList: adoptList ?? this.adoptList,
        status: status ?? this.status,
        isFollow: isFollow ?? this.isFollow,
      );
}
