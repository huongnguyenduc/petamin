part of 'home_cubit.dart';

class HomeState extends Equatable {
  HomeState({this.selectedIndex = 0});

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];

  HomeState copyWith({int? index}) {
    return HomeState(
      selectedIndex: index ?? selectedIndex,
    );
  }
}
