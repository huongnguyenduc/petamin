import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoState());

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
