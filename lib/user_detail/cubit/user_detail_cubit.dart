import 'package:Petamin/user_detail/cubit/user_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(this._petaminRepository) : super(UserDetailState());
  final PetaminRepository _petaminRepository;

  Future<void> getUserprofile(String userId) async {
    emit(state.copyWith(status: UserDetailStatus.loading));
    try {
      final profile = await _petaminRepository.getUserProfileWithId(userId);
      emit(state.copyWith(
        userId: profile.userId,
        name: profile.name,
        bio: profile.description,
        avatarUrl: profile.avatar,
        countFollowers: profile.followers,
        countFollowings: profile.followings,
        isFollow: profile.isFollow,
        status: UserDetailStatus.success,
        petList: profile.pets,
        adoptList: profile.adoptions,
      ));
    } catch (_) {
      emit(state.copyWith(status: UserDetailStatus.failure));
    }
  }

  Future<void> getMyUserprofile() async {
    emit(state.copyWith(status: UserDetailStatus.loading));
    try {
      final profile = await _petaminRepository.getUserProfile();
      // print profile json
      print('profile json: ${profile.toJson()}');
      print(profile.toJson());
      emit(state.copyWith(
        userId: profile.userId,
        name: profile.name,
        bio: profile.description,
        avatarUrl: profile.avatar,
        countFollowers: profile.followers,
        countFollowings: profile.followings,
        isFollow: profile.isFollow,
        status: UserDetailStatus.success,
        petList: profile.pets,
        adoptList: profile.adoptions,
      ));
    } catch (_) {
      emit(state.copyWith(status: UserDetailStatus.failure));
    }
  }

  Future<void> followCLick() async {
    emit(state.copyWith(status: UserDetailStatus.loading));
    EasyLoading.show();
    try {
      var result;
      if (state.isFollow == true) {
        result = await _petaminRepository.unFollowUser(state.userId);
        if (result) {
          emit(state.copyWith(
            isFollow: false,
            countFollowers: state.countFollowers - 1,
            status: UserDetailStatus.success,
          ));
        } else {
          emit(state.copyWith(status: UserDetailStatus.failure));
        }
      } else {
        result = await _petaminRepository.followUser(state.userId);
        if (result) {
          emit(state.copyWith(
            isFollow: true,
            countFollowers: state.countFollowers + 1,
            status: UserDetailStatus.success,
          ));
        } else {
          emit(state.copyWith(status: UserDetailStatus.failure));
        }
      }
    } catch (_) {
      emit(state.copyWith(status: UserDetailStatus.failure));
    }
    EasyLoading.dismiss();
  }

  Future<String> createConversations(String userId) async {
    //  debugPrint('call_cubit: $userId');
    final result = await _petaminRepository.postUserDetailConversation(userId: userId);
    return result.conversationId;
  }
}
