import 'dart:io';

import 'package:Petamin/pet_add/widgets/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'pet_add_state.dart';

class PetAddCubit extends Cubit<PetAddState> {
  PetAddCubit(this._petaminRepository) : super(PetAddState());
  PetaminRepository _petaminRepository;
  void nextStep() {
    if (state.currentStep < 7) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void nameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void breedChanged(String breed) {
    emit(state.copyWith(breed: breed));
  }

  void selectSpecies(Species species, String speciesId) {
    emit(state.copyWith(species: species, speciesId: speciesId));
  }

  void selectGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void selectNeuter(Neutered neutered) {
    emit(state.copyWith(neutered: neutered));
  }

  void selectYear(int year) {
    emit(state.copyWith(year: year));
  }

  void selectMonth(int month) {
    emit(state.copyWith(month: month));
  }

  void descriptionChanged(String description) {
    emit(state.copyWith(description: description));
  }

  void selectIntegralWeight(int integralWeight) {
    emit(state.copyWith(integralWeight: integralWeight));
  }

  void selectFractionalWeight(int fractionalWeight) {
    emit(state.copyWith(fractionalWeight: fractionalWeight));
  }

  void selectPetImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      emit(state.copyWith(
          imageFile: File(pickedFile.path), imageName: pickedFile.name));
    }
  }

  void weightChanged(double weight) {
    emit(state.copyWith(weight: weight));
  }

  Future<bool> addNewPet() async {
    debugPrint(state.props.toString());
    EasyLoading.show(status: 'Creating...');
    try {
      final result = await _petaminRepository.createPet(
          pet: Pet(
              id: '',
              name: state.name,
              month: state.month,
              year: state.year,
              gender: state.gender == Gender.FEMALE
                  ? "FEMALE"
                  : state.gender == Gender.MALE
                      ? "MALE"
                      : "OTHER",
              breed: state.breed,
              isNeuter: state.neutered == Neutered.yes ? true : false,
              avatarUrl: '',
              weight: double.tryParse(
                      '${state.integralWeight.toString()}.${state.fractionalWeight.toString()}') ??
                  0,
              description: state.description,
              photos: [],
              species: state.speciesId,
              isAdopting: false),
          avatar: state.imageFile);
      if (result) {
        EasyLoading.showSuccess('Create success');
      } else {
        EasyLoading.showError('Create failed');
      }
      return result;
    } catch (e) {}
    EasyLoading.dismiss();
    return false;
  }
}
