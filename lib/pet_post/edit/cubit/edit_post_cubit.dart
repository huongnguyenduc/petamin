import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  EditPostCubit(this._petaminRepository) : super(EditPostState());
  final PetaminRepository _petaminRepository;

  Future<void> getAdoptDetail(String petId) async {
    EasyLoading.show(status: 'Loading...');
    emit(state.copyWith(status: EditAdoptStatus.loading));
    try {
      final adopt = await _petaminRepository.getAdoptDetail(petId);
      RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
      debugPrint(adopt.price.toString().replaceAll(regex, ''));
      emit(state.copyWith(
        id: adopt.id,
        initPrice: adopt.price.toString().replaceAll(regex, ''),
        initDescription: adopt.description,
        petId: adopt.petId,
        userId: adopt.userId,
        adoptStatus: adopt.status,
        status: EditAdoptStatus.success,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: EditAdoptStatus.failure));
    }
    EasyLoading.dismiss();
  }

  Future<void> submit(String price, String description) async {
    if( price == state.initPrice && description == state.initDescription ) {
      EasyLoading.showInfo('No changes detected',);
      return;
    }
    emit(state.copyWith(status: EditAdoptStatus.loading));
    EasyLoading.show(status: 'loading...');
    try {
      final result = await _petaminRepository.updateAdopt(Adopt(
          petId: state.petId,
          userId: state.userId,
          id: state.id,
          price: double.tryParse(price),
          description: description,
          status: ''));
      if (result) {
        EasyLoading.showSuccess('Edit success');
      } else {
        EasyLoading.showError('Edit failed');
      }
      emit(state.copyWith(status: EditAdoptStatus.success));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: EditAdoptStatus.failure));
    }
    EasyLoading.dismiss();
  }
}
