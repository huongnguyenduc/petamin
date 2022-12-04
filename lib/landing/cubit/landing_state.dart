part of 'landing_cubit.dart';

class LandingState extends Equatable {
  final List<PetCardData> pets;

  LandingState({this.pets = const []});

  @override
  List<Object> get props => [pets];

  LandingState copyWith({
    List<PetCardData>? pets,
  }) {
    return LandingState(
      pets: pets ?? this.pets,
    );
  }
}

List<PetCardData> petsMock = [
  PetCardData(
      petId: '1',
      adoptId: '1',
      name: 'Huy',
      photo:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=80",
      breed: "Persian",
      age: '1',
      sex: "Female",
      price: 1),
  PetCardData(
      petId: '2',
      adoptId: '2',
      name: "Huy",
      photo:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=80",
      breed: "Persian",
      age: '1',
      sex: "Female",
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
