import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit(this._petaminRepository) : super(ProfileInfoState());
  PetaminRepository _petaminRepository;

  Future<void> getProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      Profile profile = await _petaminRepository.getUserProfile();

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          bio: profile.description,
          address: profile.address,
          dayOfBirth: profile.birthday != null && profile.birthday!.isNotEmpty
              ? profile.birthday
              : DateTime.now().toUtc().toString(),
          phoneNumber: profile.phone,
          avatarUrl: profile.avatar,
          name: profile.name,
          email: profile.email,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: ProfileStatus.failure));
    } catch (e) {
      print("Get Profile Error: $e");
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  // Update Profile
  Future<void> updateProfile() async {
    emit(state.copyWith(submitStatus: ProfileStatus.loading));

    try {
      await _petaminRepository.updateUserProfile(
        name: state.name,
        description: state.bio,
        address: state.address,
        birthday: state.dayOfBirth,
        phone: state.phoneNumber,
        avatar: state.avatar,
      );

      emit(state.copyWith(submitStatus: ProfileStatus.success));
    } on Exception {
      emit(state.copyWith(submitStatus: ProfileStatus.failure));
    }
  }

  void selectProfileImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      emit(state.copyWith(avatar: File(pickedFile.path)));
    }
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void updateAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updateDayOfBirth(String dayOfBirth) {
    emit(state.copyWith(dayOfBirth: dayOfBirth));
  }

  void updateBio(String bio) {
    emit(state.copyWith(bio: bio));
  }
}
