import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'pet_add_state.dart';

class PetAddCubit extends Cubit<PetAddState> {
  PetAddCubit() : super(PetAddState());

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

  void selectSpecies(Species species) {
    emit(state.copyWith(species: species));
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
}
