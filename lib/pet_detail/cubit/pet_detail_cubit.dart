import 'package:Petamin/pet_detail/cubit/pet_detail_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetDetailCubit extends Cubit<PetDetailState> {
  PetDetailCubit(this._petaminRepository) : super(PetDetailState());

  final PetaminRepository _petaminRepository;
  Future<void> getPetDetail({required String id}) async {
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
      final pet = await _petaminRepository.getPetDetail(id: id);
      emit(state.copyWith(pet: pet, status: PetDetailStatus.success));
    } catch (e) {
      emit(state.copyWith(pet: Pet.empty, status: PetDetailStatus.failure));
    }
  }
  Future<void> updatePet({required Pet pet}) async {
    debugPrint("Update Pet Cubit");
    emit(state.copyWith(status: PetDetailStatus.loading));
    try {
       await _petaminRepository.updatePet(pet: pet);
    
    } catch (e) {
      emit(state.copyWith(pet: Pet.empty, status: PetDetailStatus.failure));
    }
  }
}
