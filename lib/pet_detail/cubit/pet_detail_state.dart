import 'package:equatable/equatable.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetDetailState extends Equatable {
   PetDetailState({
    this.pet = Pet.empty,
    this.status = PetDetailStatus.initial,
  });

  final Pet pet;
  final PetDetailStatus status;
  @override
  List<Object> get props => [pet, status];

  PetDetailState copyWith({
    Pet? pet,
    PetDetailStatus? status,
  }) {
    return PetDetailState(
      pet: pet ?? this.pet,
      status: status ?? this.status,
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