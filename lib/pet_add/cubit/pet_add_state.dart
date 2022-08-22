part of 'pet_add_cubit.dart';

enum Species { cat, dog, bird, pocketPet, unselected }

class PetAddState extends Equatable {
  const PetAddState({this.currentStep = 1, this.species = Species.unselected});

  final int currentStep;
  final Species species;

  @override
  List<Object> get props => [currentStep, species];

  PetAddState copyWith({int? currentStep, Species? species}) {
    return PetAddState(
        currentStep: currentStep ?? this.currentStep,
        species: species ?? this.species);
  }
}
