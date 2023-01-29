part of 'landing_cubit.dart';

class LandingState extends Equatable {
  final List<PetCardData> pets;
  final bool isOnline;

  LandingState({this.pets = const [], this.isOnline = false});

  @override
  List<Object> get props => [pets, isOnline];

  LandingState copyWith({
    List<PetCardData>? pets,
    bool? isOnline,
  }) {
    return LandingState(
      pets: pets ?? this.pets,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}

List<PetCardData> petsMock = [
  PetCardData(
      petId: '1',
      adoptId: '1',
      name: 'Huy',
      photo:
          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=80',
      breed: 'Persian',
      age: '1',
      sex: 'Female',
      price: 1),
  PetCardData(
      petId: '2',
      adoptId: '2',
      name: 'Huy',
      photo:
          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=80',
      breed: 'Persian',
      age: '1',
      sex: 'Female',
      price: 1),
  PetCardData(
      petId: '3',
      adoptId: '3',
      name: 'Huy',
      photo:
          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=80',
      breed: 'Persian',
      age: '1',
      sex: 'Female',
      price: 1),
];
