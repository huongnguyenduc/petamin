part of 'transfer_pet_cubit.dart';

@immutable
class TransferPetState extends Equatable {
  final Name newOwnerName;
  final FormzStatus status;
  final String reciverId;
  const TransferPetState({
    this.newOwnerName = const Name.pure(),
    this.status = FormzStatus.pure,
    this.reciverId = '',
  });

  @override
  List<Object> get props => [newOwnerName, status, reciverId];

  TransferPetState copyWith({
    Name? newOwnerName,
    FormzStatus? status,
    String? reciverId,
  }) {
    return TransferPetState(
      newOwnerName: newOwnerName ?? this.newOwnerName,
      status: status ?? this.status,
      reciverId: reciverId ?? this.reciverId,
    );
  }
}
