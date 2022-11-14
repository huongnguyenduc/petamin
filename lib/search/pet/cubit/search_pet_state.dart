part of 'search_pet_cubit.dart';

enum SearchPetStatus {
  newQuery,
  initial,
  searching,
  success,
  failure,
}

class SearchPetState extends Equatable {
  final List<Species> selectedSpecies;
  final String minPrice;
  final String maxPrice;
  final String searchQuery;
  List<Adopt> searchResults;
  final PaginationData paginationData;
  final SearchPetStatus status;
  SearchPetState({
    this.selectedSpecies = const [],
    this.minPrice = '0',
    this.maxPrice = '0',
    this.searchQuery = '',
    this.status = SearchPetStatus.initial,
    this.searchResults = const [],
    this.paginationData = const PaginationData.initial(),
  });

  SearchPetState copyWith({
    List<Species>? selectedSpecies,
    String? minPrice,
    String? maxPrice,
    String? searchQuery,
    SearchPetStatus? status,
    List<Adopt>? searchResults,
    PaginationData? paginationData,
  }) {
    return SearchPetState(
      selectedSpecies: selectedSpecies ?? this.selectedSpecies,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      searchResults: searchResults ?? this.searchResults,
      paginationData: paginationData ?? this.paginationData,
    );
  }

  @override
  List<Object> get props => [
        selectedSpecies,
        status,
        searchResults,
        paginationData,
        searchQuery,
        minPrice,
        maxPrice
      ];
}
