part of 'pet_add_cubit.dart';

class PetAddState extends Equatable {
  const PetAddState({this.currentStep = 1});

  final int currentStep;
  @override
  List<Object> get props => [currentStep];

  PetAddState copyWith({int? currentStep}) {
    return PetAddState(
      currentStep: currentStep ?? this.currentStep,
    );
  }
}
