import 'package:Petamin/data/api/auth_api.dart';
import 'package:Petamin/data/models/user_model.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._petaminRepository) : super(const SignUpState());

  final PetaminRepository _petaminRepository;
  final _authApi = AuthApi();
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void createUser(
      {required String name, required String email, required String uId}) {
    UserModel user = UserModel.resister(
        name: name,
        id: uId,
        email: email,
        avatar: 'https://i.pravatar.cc/300',
        busy: false);
    _authApi.createUser(user: user).then((value) {}).catchError((onError) {});
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _petaminRepository.signUp(
        email: state.email.value,
        password: state.password.value,
        name: state.email.value.split('@')[0],
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
