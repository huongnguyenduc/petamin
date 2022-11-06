part of 'transfer_pet_cubit.dart';

@immutable
class TransferPetState extends Equatable {
  final Name newOwnerName;
  final FormzStatus status;

  const TransferPetState({
    this.newOwnerName = const Name.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [newOwnerName, status];

  TransferPetState copyWith({
    Name? newOwnerName,
    FormzStatus? status,
  }) {
    return TransferPetState(
      newOwnerName: newOwnerName ?? this.newOwnerName,
      status: status ?? this.status,
    );
  }
}
