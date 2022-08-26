part of 'pet_add_cubit.dart';

enum Species { cat, dog, bird, pocketPet, unselected }

enum Gender { male, female, unknown }

enum Neutered { yes, no, unknown }

class PetAddState extends Equatable {
  const PetAddState(
      {this.currentStep = 1,
      this.species = Species.unselected,
      this.gender = Gender.unknown,
      this.neutered = Neutered.unknown,
      this.year = 0,
      this.month = 0});

  final int currentStep;
  final Species species;
  final Gender gender;
  final Neutered neutered;
  final int year;
  final int month;

  @override
  List<Object> get props =>
      [currentStep, species, gender, neutered, year, month];

  PetAddState copyWith(
      {int? currentStep,
      Species? species,
      Gender? gender,
      Neutered? neutered,
      int? year,
      int? month}) {
    return PetAddState(
        currentStep: currentStep ?? this.currentStep,
        species: species ?? this.species,
        gender: gender ?? this.gender,
        neutered: neutered ?? this.neutered,
        year: year ?? this.year,
        month: month ?? this.month);
  }
}
