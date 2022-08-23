part of 'pet_add_cubit.dart';

enum Species { cat, dog, bird, pocketPet, unselected }

enum Gender { male, female, unknown }

enum Neutered { yes, no, unknown }

class PetAddState extends Equatable {
  const PetAddState(
      {this.currentStep = 1,
      this.species = Species.unselected,
      this.gender = Gender.unknown,
      this.neutered = Neutered.unknown});

  final int currentStep;
  final Species species;
  final Gender gender;
  final Neutered neutered;

  @override
  List<Object> get props => [currentStep, species, gender, neutered];

  PetAddState copyWith(
      {int? currentStep,
      Species? species,
      Gender? gender,
      Neutered? neutered}) {
    return PetAddState(
        currentStep: currentStep ?? this.currentStep,
        species: species ?? this.species,
        gender: gender ?? this.gender,
        neutered: neutered ?? this.neutered);
  }
}
