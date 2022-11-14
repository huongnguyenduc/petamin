part of 'pet_add_cubit.dart';

enum Species { CAT, DOG, BIRD, POCKET_PET, UNSELECTED }

enum Gender { MALE, FEMALE, OTHER }

enum Neutered { yes, no, unknown }

class PetAddState extends Equatable {
  const PetAddState(
      {this.name = "",
      this.breed = "",
      this.currentStep = 1,
      this.species = Species.UNSELECTED,
      this.speciesId = "",
      this.gender = Gender.OTHER,
      this.neutered = Neutered.unknown,
      this.year = 0,
      this.month = 0,
      this.description = "",
      this.integralWeight = 0,
      this.fractionalWeight = 0,
      this.imageFile,
      this.weight = 0,
      this.imageName = ""});

  final String name;
  final String breed;
  final int currentStep;
  final Species species;
  final String speciesId;
  final Gender gender;
  final Neutered neutered;
  final int year;
  final int month;
  final String description;
  final int integralWeight;
  final int fractionalWeight;
  final double weight;
  final File? imageFile;
  final String imageName;

  @override
  List<Object> get props => [
        name,
        month,
        year,
        gender,
        breed,
        neutered,
        species,
        description,
        integralWeight,
        fractionalWeight,
        imageName,
        currentStep,
      ];

  PetAddState copyWith(
      {String? name,
      String? breed,
      int? currentStep,
      Species? species,
      String? speciesId,
      Gender? gender,
      Neutered? neutered,
      int? year,
      int? month,
      String? description,
      int? integralWeight,
      int? fractionalWeight,
      File? imageFile,
      double? weight,
      String? imageName}) {
    return PetAddState(
        name: name ?? this.name,
        breed: breed ?? this.breed,
        currentStep: currentStep ?? this.currentStep,
        species: species ?? this.species,
        speciesId: speciesId ?? this.speciesId,
        gender: gender ?? this.gender,
        neutered: neutered ?? this.neutered,
        year: year ?? this.year,
        month: month ?? this.month,
        description: description ?? this.description,
        integralWeight: integralWeight ?? this.integralWeight,
        fractionalWeight: fractionalWeight ?? this.fractionalWeight,
        imageFile: imageFile ?? this.imageFile,
        weight: weight ?? this.weight,
        imageName: imageName ?? this.imageName);
  }
}
