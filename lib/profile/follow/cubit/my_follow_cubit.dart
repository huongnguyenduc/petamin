import 'package:Petamin/profile/follow/cubit/my_follow_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

class MyFollowCubit extends Cubit<MyFollowState> {
  MyFollowCubit(this._petaminRepository) : super(MyFollowState());
  final PetaminRepository _petaminRepository;
  Future<void> getFollows(String userId) async {
    EasyLoading.show();
    emit(state.copyWith(status: FollowStatus.loading));
    try {
      final followers = await _petaminRepository.getFollowers(
        userId: userId,
      );
      final followings = await _petaminRepository.getFollowing(
        userId: userId,
      );
      emit(state.copyWith(
        followers: followers,
        following: followings,
        status: FollowStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: FollowStatus.failure));
    }
    EasyLoading.dismiss();
  }

  Future<void> follow(String userId, bool isFollower) async {
    emit(state.copyWith(status: FollowStatus.loading));
    EasyLoading.show();
    try {
      final result = await _petaminRepository.followUser(userId);
      if (result) {
        if (isFollower) {
          final newFollowers = state.followers;
          newFollowers
              .firstWhere((element) => element.userId == userId)
              .isFollow = true;
          emit(state.copyWith(
            status: FollowStatus.success,
            followers: newFollowers,
          ));
        } else {
          final newFollowings = state.following;
          newFollowings
              .firstWhere((element) => element.userId == userId)
              .isFollow = true;
          emit(state.copyWith(
            status: FollowStatus.success,
            following: newFollowings,
          ));
        }
      } else {
        EasyLoading.showError('Failed to Follow');
        emit(state.copyWith(status: FollowStatus.failure));
      }
    } catch (_) {
      EasyLoading.showError('Failed to Follow');
      emit(state.copyWith(status: FollowStatus.failure));
    }
    EasyLoading.dismiss();
  }

  Future<void> unFollow(String userId, bool isFollower) async {
    emit(state.copyWith(status: FollowStatus.loading));
    EasyLoading.show();
    try {
      final result = await _petaminRepository.unFollowUser(userId);
      if (result) {
        if (isFollower) {
          final newFollowers = state.followers;
          newFollowers
              .firstWhere((element) => element.userId == userId)
              .isFollow = false;
          emit(state.copyWith(
            status: FollowStatus.success,
            followers: newFollowers,
          ));
        } else {
          final newFollowings = state.following;
          newFollowings
              .firstWhere((element) => element.userId == userId)
              .isFollow = false;
          emit(state.copyWith(
            status: FollowStatus.success,
            following: newFollowings,
          ));
        }
      } else {
        EasyLoading.showError('Failed to unfollow');
        emit(state.copyWith(status: FollowStatus.failure));
      }
    } catch (_) {
      EasyLoading.showError('Failed to unfollow');
      emit(state.copyWith(status: FollowStatus.failure));
    }
    EasyLoading.dismiss();
  }
}
