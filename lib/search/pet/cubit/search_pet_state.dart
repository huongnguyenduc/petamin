part of 'search_pet_cubit.dart';

class SearchPetState extends Equatable {
  final List<Species> selectedSpecies;
  final int minPrice;
  final int maxPrice;
  final String query;

  SearchPetState({
    this.selectedSpecies = const [],
    this.minPrice = 0,
    this.maxPrice = 0,
    this.query = "",
  });

  SearchPetState copyWith({
    List<Species>? selectedSpecies,
    int? minPrice,
    int? maxPrice,
    String? query,
  }) {
    return SearchPetState(
      selectedSpecies: selectedSpecies ?? this.selectedSpecies,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [selectedSpecies, minPrice, maxPrice, query];
}
