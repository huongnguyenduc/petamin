import 'package:Petamin/pet_detail/cubit/pet_detail_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetDetailCubit extends Cubit<PetDetailState> {
  PetDetailCubit(this._petaminRepository) : super(PetDetailState());

  final PetaminRepository _petaminRepository;
  Future<void> getPetDetail({required String id}) async {
    EasyLoading.show();
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      final pet = await _petaminRepository.getPetDetail(id: id);
      emit(state.copyWith(pet: pet, status: PetDetailStatus.success));
    } catch (e) {
      emit(state.copyWith(pet: Pet.empty, status: PetDetailStatus.failure));
    }
    EasyLoading.dismiss();
  }

  Future<void> updatePet({required Pet pet}) async {
    debugPrint('Update Pet Cubit');
    EasyLoading.show(status: 'Loading...');
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      await _petaminRepository.updatePet(pet: pet);
    } catch (e) {
      emit(state.copyWith(pet: Pet.empty, status: PetDetailStatus.failure));
    }
    EasyLoading.dismiss();
    // await this.getPetDetail(id: pet.id!);
  }

  Future<bool> deletePhoto({required String id}) async {
    debugPrint('Delete Photo Cubit');
    EasyLoading.show(status: 'Deleting...');
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      final result = await _petaminRepository.deletePhotos(
          photoId: id, petId: state.pet.id!);
      if (result) {
        final pet = state.pet;
        pet.photos!.removeWhere((element) => element.id == id);
        emit(state.copyWith(pet: pet, status: PetDetailStatus.success));
        EasyLoading.showSuccess('Delete success');
      } else {
        EasyLoading.showError('Delete failed');
      }
      return result;
    } catch (e) {
      emit(state.copyWith(pet: Pet.empty, status: PetDetailStatus.failure));
    }
    EasyLoading.dismiss();
    return false;
  }
}
