part of 'pet_adopt_cubit.dart';

enum PetAdoptView { owner, viewer }

enum PetAdoptAvailability { show, hide }

class PetAdoptState extends Equatable {
  PetAdoptState({
    this.pet = Pet.empty,
    this.profile = Profile.empty,
    this.adoptInfo = Adopt.empty,
    this.status = PetDetailStatus.initial,
    this.view = PetAdoptView.viewer,
    this.availability = PetAdoptAvailability.show,
  });

  final Pet pet;
  final Adopt adoptInfo;
  final Profile profile;
  final PetDetailStatus status;
  final PetAdoptView view;
  final PetAdoptAvailability availability;

  @override
  List<Object> get props => [pet, status, view, adoptInfo, availability];

  PetAdoptState copyWith({
    Pet? pet,
    PetDetailStatus? status,
    PetAdoptView? view,
    Adopt? adoptInfo,
    PetAdoptAvailability? availability,
    Profile? profile,
  }) {
    return PetAdoptState(
      pet: pet ?? this.pet,
      status: status ?? this.status,
      view: view ?? this.view,
      adoptInfo: adoptInfo ?? this.adoptInfo,
      availability: availability ?? this.availability,
      profile: profile ?? this.profile,
    );
  }
}

enum PetDetailStatus { initial, loading, success, failure }

extension PetListStatusX on PetDetailStatus {
  bool get isInitial => this == PetDetailStatus.initial;

  bool get isLoading => this == PetDetailStatus.loading;

  bool get isSuccess => this == PetDetailStatus.success;

  bool get isFailure => this == PetDetailStatus.failure;
}
