import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit(this._petaminRepository) : super(CreatePostState());

  final PetaminRepository _petaminRepository;

  Future<void> submit(String price, String description, String petId) async {
    EasyLoading.show(status: 'loading...');
    try {
      final result = 
      await _petaminRepository.createAdopt(Adopt(
          id: '',
          petId: petId,
          userId: '',
          price: double.tryParse(price),
          description: description,
          status: ''));
      if (result) {
        EasyLoading.showSuccess("Posted!");
        emit(state.copyWith(status: PostAdoptStatus.isPosted));
      } else {
        EasyLoading.showError("Failed to post!");
        emit(state.copyWith(status: PostAdoptStatus.success));
      }
      //  emit(state.copyWith(status: PostAdoptStatus.success));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: PostAdoptStatus.failure));
    }
    EasyLoading.dismiss();
  }
}
