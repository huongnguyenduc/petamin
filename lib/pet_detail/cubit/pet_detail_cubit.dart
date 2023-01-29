import 'dart:io';

import 'package:Petamin/pet_detail/cubit/pet_detail_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetDetailCubit extends Cubit<PetDetailState> {
  PetDetailCubit(this._petaminRepository) : super(PetDetailState());

  final PetaminRepository _petaminRepository;

  Future<void> getPetDetail({required String id, required String userId}) async {
    EasyLoading.show();
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      final pet = await _petaminRepository.getPetDetail(id: id);
      if (pet.userId == userId) {
        emit(state.copyWith(pet: pet, view: PetDetailView.owner));
      } else {
        emit(state.copyWith(pet: pet, view: PetDetailView.viewer));
      }
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

  void selectPetImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      emit(state.copyWith(pet: state.pet.copyWith(avatar: File(pickedFile.path))));
    }
  }

  void selectMultipleImages() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles != null) {
      EasyLoading.show(status: 'Uploading...');
      print('Picked files: $pickedFiles');
      try {
        emit(state.copyWith(status: PetDetailStatus.loading));
        final List<File> files = pickedFiles.map((e) => File(e.path)).toList();
        await _petaminRepository.addPhotos(files: files, petId: state.pet.id!);
        final pet = await _petaminRepository.getPetDetail(id: state.pet.id!);
        emit(state.copyWith(
          pet: pet,
          status: PetDetailStatus.success,
        ));
      } catch (e) {
        print('Error upload image: $e');
        emit(state.copyWith(status: PetDetailStatus.failure));
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  Future<bool> deletePhoto({required String id}) async {
    debugPrint('Delete Photo Cubit');
    EasyLoading.show(status: 'Deleting...');
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      final result = await _petaminRepository.deletePhotos(photoId: id, petId: state.pet.id!);
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
