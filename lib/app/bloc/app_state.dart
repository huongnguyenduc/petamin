part of 'app_bloc.dart';

enum SessionStatus {
  authenticated,
  unauthenticated,
}

class AppSessionState extends Equatable {
  const AppSessionState._({
    required this.sessionStatus,
    this.session = Session.empty,
  });

  const AppSessionState.authenticatedSession(Session session)
      : this._(session: session, sessionStatus: SessionStatus.authenticated);

  const AppSessionState.unauthenticatedSession()
      : this._(sessionStatus: SessionStatus.unauthenticated);

  final SessionStatus sessionStatus;
  final Session session;

  @override
  List<Object> get props => [sessionStatus, session];
}
