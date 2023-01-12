import 'dart:io';

import 'package:Petamin/pet_detail/pet_detail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'pet_adopt_state.dart';

class PetAdoptCubit extends Cubit<PetAdoptState> {
  PetAdoptCubit(this._petaminRepository) : super(PetAdoptState());

  final PetaminRepository _petaminRepository;

  Future<void> getPetDetail(
      {required String id, required String userId}) async {
    EasyLoading.show();
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      final pet = await _petaminRepository.getPetDetail(id: id);

      final adopt = await _petaminRepository.getAdoptDetail(id);

      final profile =
          await _petaminRepository.getUserProfileWithId(pet.userId!);

      final view =
          pet.userId == userId ? PetAdoptView.owner : PetAdoptView.viewer;
      final availability = adopt.status == 'SHOW'
          ? PetAdoptAvailability.show
          : PetAdoptAvailability.hide;

      emit(state.copyWith(
          pet: pet,
          adoptInfo: adopt,
          view: view,
          availability: availability,
          status: PetDetailStatus.success,
          profile: profile));
      print('5');
    } catch (e) {
      print('6');
      emit(state.copyWith(pet: Pet.empty, status: PetDetailStatus.failure));
    }
    print('7');
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

  Future<void> toggleAdoptPet() async {
    debugPrint('Update Pet Cubit');
    EasyLoading.show(status: 'Loading...');
    final currentAvailability = state.availability == PetAdoptAvailability.show
        ? PetAdoptAvailability.show
        : PetAdoptAvailability.hide;
    final newAvailability = currentAvailability == PetAdoptAvailability.show
        ? PetAdoptAvailability.hide
        : PetAdoptAvailability.show;
    final newAvailablityString =
        newAvailability == PetAdoptAvailability.show ? 'SHOW' : 'HIDE';
    emit(state.copyWith(
        status: PetDetailStatus.loading, availability: newAvailability));
    try {
      await _petaminRepository.toggleAdoptPost(
          state.adoptInfo.id!, newAvailablityString);
    } catch (e) {
      emit(state.copyWith(
          status: PetDetailStatus.loading, availability: currentAvailability));
    }
    EasyLoading.dismiss();
  }

  void selectPetImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      emit(state.copyWith(
          pet: state.pet.copyWith(avatar: File(pickedFile.path))));
    }
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

  Future<bool> deleteAdoptPost(
      {required String id, required BuildContext context}) async {
    debugPrint('Delete Adopt Post');
    EasyLoading.show(status: 'Deleting...');
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      final result = await _petaminRepository.deleteAdoptPost(adoptId: id);
      if (result) {
        EasyLoading.showSuccess('Delete success');
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => PetDetailPage(
                  id: state.pet.id!,
                )));
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
