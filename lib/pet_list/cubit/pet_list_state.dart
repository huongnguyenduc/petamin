import 'package:equatable/equatable.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetListState extends Equatable {
  const PetListState({
    this.pets = const [],
    this.status = PetListStatus.initial,
  });

  final List<Pet> pets;
  final PetListStatus status;
  @override
  List<Object> get props => [pets, status];

  PetListState copyWith({
    List<Pet>? pets,
    PetListStatus? status,
  }) {
    return PetListState(
      pets: pets ?? this.pets,
      status: status ?? this.status,
    );
  }
}

enum PetListStatus { initial, loading, success, failure }
extension PetListStatusX on PetListStatus {
  bool get isInitial => this == PetListStatus.initial;
  bool get isLoading => this == PetListStatus.loading;
  bool get isSuccess => this == PetListStatus.success;
  bool get isFailure => this == PetListStatus.failure;
}