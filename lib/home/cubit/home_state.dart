part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState({this.selectedIndex = 0});

  final int selectedIndex;

  // @override
  // List<Object> get props => [selectedIndex];

  HomeState copyWith({int? index});
  //{
  //   return HomeState(selectedIndex: index ?? selectedIndex);
  // }
}

class HomeInitial extends HomeState {
  HomeInitial({super.selectedIndex = 0});

  //final int selectedIndex;

  @override
  List<Object> get props => [super.selectedIndex];

  @override
  HomeInitial copyWith({int? index}) {
    return HomeInitial(selectedIndex: index ?? super.selectedIndex);
  }
}

class ChangeCurrentPageState extends HomeState {
  final int selectedIndex;

  ChangeCurrentPageState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];

  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class LoadingGetUsersState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class SuccessGetUsersState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ErrorGetUsersState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final String message;

  ErrorGetUsersState(this.message);
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class LoadingGetCallHistoryState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class SuccessGetCallHistoryState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ErrorGetCallHistoryState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final String message;

  ErrorGetCallHistoryState(this.message);
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

//Sender
class LoadingFireVideoCallState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class SuccessFireVideoCallState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final CallModel callModel;

  SuccessFireVideoCallState({required this.callModel});
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ErrorFireVideoCallState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final String message;
  ErrorFireVideoCallState(this.message);
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ErrorPostCallToFirestoreState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final String message;
  ErrorPostCallToFirestoreState(this.message);
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ErrorUpdateUserBusyStatus extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final String message;
  ErrorUpdateUserBusyStatus(this.message);
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class ErrorSendNotification extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final String message;
  ErrorSendNotification(this.message);
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

//Incoming Call
class SuccessInComingCallState extends HomeState {
  late final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
  final CallModel callModel;

  SuccessInComingCallState({required this.callModel});
  @override
  HomeState copyWith({int? index}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
