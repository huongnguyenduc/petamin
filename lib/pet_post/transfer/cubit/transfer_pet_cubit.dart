import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'transfer_pet_state.dart';

class TransferPetCubit extends Cubit<TransferPetState> {
  TransferPetCubit() : super(TransferPetState());

  void newOwnerNameChanged(String value) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        newOwnerName: name,
        status: Formz.validate([name, state.newOwnerName]),
      ),
    );
  }

  void transferPet() {
    //TODO: call api transfer pet
  }
}
