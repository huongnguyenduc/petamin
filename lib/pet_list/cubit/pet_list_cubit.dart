import 'package:Petamin/pet_list/cubit/pet_list_state.dart';
import 'package:bloc/bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class PetListCubit extends Cubit<PetListState> {
  PetListCubit(this._petaminRepository) : super(PetListState());

  final PetaminRepository _petaminRepository;
  Future<void> getPets() async {
    emit(state.copyWith(status: PetListStatus.loading));
    try {
      final pets = await _petaminRepository.getPets();
      emit(state.copyWith(
        pets: pets,
        status: PetListStatus.success));
    } catch (e) {
      emit(state.copyWith(pets: [],status: PetListStatus.failure));
    }
  }
}
