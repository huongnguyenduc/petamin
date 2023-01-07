import 'package:equatable/equatable.dart';
import 'package:petamin_repository/petamin_repository.dart';

enum PetDetailView { owner, viewer }

class PetDetailState extends Equatable {
  PetDetailState({
    this.pet = Pet.empty,
    this.status = PetDetailStatus.initial,
    this.view = PetDetailView.viewer,
  });

  final Pet pet;
  final PetDetailStatus status;
  final PetDetailView view;

  @override
  List<Object> get props => [pet, status, view];

  PetDetailState copyWith({
    Pet? pet,
    PetDetailStatus? status,
    PetDetailView? view,
  }) {
    return PetDetailState(
      pet: pet ?? this.pet,
      status: status ?? this.status,
      view: view ?? this.view,
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