import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  EditPostCubit() : super(EditPostState());

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
