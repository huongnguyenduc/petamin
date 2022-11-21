import 'package:equatable/equatable.dart';
import 'package:petamin_repository/petamin_repository.dart';

enum FollowStatus { initial, loading, success, failure }

class MyFollowState extends Equatable {
  MyFollowState({
    this.followers = const [],
    this.following = const [],
    this.status = FollowStatus.initial,
  });
  final List<Profile> followers;
  final List<Profile> following;
  final FollowStatus status;
  @override
  List<Object> get props => [followers, following, status];

  MyFollowState copyWith({
    FollowStatus? status,
    List<Profile>? followers,
    List<Profile>? following,
  }) =>
      MyFollowState(
        followers: followers ?? this.followers,
        following: following ?? this.following,
        status: status ?? this.status,
      );
}
