part of 'app_bloc.dart';

abstract class AppSessionEvent extends Equatable {
  const AppSessionEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutSessionRequested extends AppSessionEvent {}

class AppSessionChanged extends AppSessionEvent {
  @visibleForTesting
  const AppSessionChanged(this.session);

  final Session session;

  @override
  List<Object> get props => [session];
}
