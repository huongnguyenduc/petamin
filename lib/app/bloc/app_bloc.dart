import 'dart:async';

import 'package:petamin_repository/petamin_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppSessionBloc extends Bloc<AppSessionEvent, AppSessionState> {
  AppSessionBloc({required PetaminRepository petaminRepository})
      : _petaminRepository = petaminRepository,
        super(petaminRepository.availableSession != Session.empty
            ? AppSessionState.authenticatedSession(
                petaminRepository.availableSession)
            : const AppSessionState.unauthenticatedSession()) {
    on<AppSessionChanged>(_onSessionChanged);
    on<AppLogoutSessionRequested>(_onLogoutSessionRequested);
    _sessionSubscription = _petaminRepository.session.listen(
      (session) => add(AppSessionChanged(session)),
    );
  }

  final PetaminRepository _petaminRepository;
  late final StreamSubscription<Session> _sessionSubscription;

  void _onSessionChanged(
      AppSessionChanged event, Emitter<AppSessionState> emit) {
    emit(
      event.session.isNotEmpty
          ? AppSessionState.authenticatedSession(event.session)
          : const AppSessionState.unauthenticatedSession(),
    );
  }

  void _onLogoutSessionRequested(
      AppLogoutSessionRequested event, Emitter<AppSessionState> emit) {
    unawaited(_petaminRepository.logOut());
  }

  @override
  Future<void> close() {
    _sessionSubscription.cancel();
    return super.close();
  }
}
