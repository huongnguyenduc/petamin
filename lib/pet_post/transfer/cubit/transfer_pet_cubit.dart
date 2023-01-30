import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:petamin_repository/src/models/user_pagination.dart';

part 'transfer_pet_state.dart';

class TransferPetCubit extends Cubit<TransferPetState> {
  TransferPetCubit(this._petaminRepository) : super(TransferPetState());
  final PetaminRepository _petaminRepository;
  void newOwnerNameChanged(String value) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        newOwnerName: name,
        status: Formz.validate([name, state.newOwnerName]),
      ),
    );
  }

  void updateReciverId(String reciverId) {
    emit(state.copyWith(reciverId: reciverId));
  }

  Future<void> transferPet(String petId, BuildContext context) async {
    if (state.reciverId == '') {
      EasyLoading.showInfo('Please select a new owner');
    }
    try {
      final result = await _petaminRepository.transferPet(
          petId: petId, reciverId: state.reciverId);
      if (result == true) {
        EasyLoading.showSuccess('Transfer Success');
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        EasyLoading.showError('Transfer Failed');
      }
    } catch (e) {
      EasyLoading.showError('Transfer Failed');
    }
  }
}
