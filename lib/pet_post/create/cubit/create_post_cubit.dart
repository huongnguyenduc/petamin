import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostState());

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
