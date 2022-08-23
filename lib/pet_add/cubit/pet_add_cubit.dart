import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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

  void selectSpecies(Species species) {
    emit(state.copyWith(species: species));
  }

  void selectGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void selectNeuter(Neutered neutered) {
    emit(state.copyWith(neutered: neutered));
  }
}
