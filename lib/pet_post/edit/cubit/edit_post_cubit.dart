import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  EditPostCubit(this._petaminRepository) : super(EditPostState());
  final PetaminRepository _petaminRepository;

  Future<void> getAdoptDetail(String petId) async {
    final adopt = await _petaminRepository.getAdoptDetail(petId);
    emit(state.copyWith(
      initPrice: adopt.price.toString(),
      initDescription: adopt.description,
    ));
  }
  void priceChanged(String value) {
    final price = Price.dirty(value);
    emit(
      state.copyWith(
        price: price,
        status: Formz.validate([price, state.price]),
      ),
    );
  }

  void descriptionChanged(String description) {
    emit(state.copyWith(description: description));
  }

  void submit() {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
  }
}
