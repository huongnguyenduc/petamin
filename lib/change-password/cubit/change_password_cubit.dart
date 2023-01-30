import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required this.petaminRepository}) : super(ChangePasswordInitial());

  final PetaminRepository petaminRepository;

  void changePassword({required String oldPassword, required String newPassword}) async {
    emit(ChangePasswordLoading());
    try {
      EasyLoading.show(status: 'Changing password...');
      bool isSuccess = await petaminRepository.changePassword(oldPassword: oldPassword, newPassword: newPassword);
      if (isSuccess) {
        EasyLoading.showSuccess('Password changed');
        emit(ChangePasswordSuccess());
      } else {
        EasyLoading.showError('Old password is incorrect');
        emit(ChangePasswordFailure());
      }
    } catch (e) {
      emit(ChangePasswordFailure());
      EasyLoading.showError('Failed to change password');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
