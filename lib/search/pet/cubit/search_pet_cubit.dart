import 'dart:async';

import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/search/pet/search_pet.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

part 'search_pet_state.dart';

class SearchPetCubit extends Cubit<SearchPetState> {
  final PetaminRepository _petaminRepository;

  final Species? initSelectedSpecies;

  final searchBarFocusNode = FocusNode();

  void requestFocusSearchBar() {
    searchBarFocusNode.requestFocus();
  }

  SearchPetCubit(this._petaminRepository, {this.initSelectedSpecies})
      : super(SearchPetState(selectedSpecies: initSelectedSpecies != null ? [initSelectedSpecies] : []));

  void selectSpecies(Species species) async {
    if (isSpeciesSelected(species)) {
      emit(state.copyWith(selectedSpecies: state.selectedSpecies.where((element) => element != species).toList()));
    } else {
      emit(state.copyWith(selectedSpecies: [...state.selectedSpecies, species]));
    }
    await searchAdoption(state.searchQuery, true);
  }

  void setMinPrice(String price) async {
    debugPrint('setMinPrice: $price');
    emit(state.copyWith(minPrice: price));
    debugPrint('setMinPrice: ${state.minPrice}');
    await searchAdoption(state.searchQuery, true);
  }

  void setMaxPrice(String maxPrice) async {
    emit(state.copyWith(maxPrice: maxPrice));
    await searchAdoption(state.searchQuery, true);
  }

  void resetFilter() async {
    emit(state.copyWith(selectedSpecies: [], minPrice: '0', maxPrice: '0'));
    await searchAdoption(state.searchQuery, true);
  }

  bool isSpeciesSelected(Species species) {
    return state.selectedSpecies.contains(species);
  }

  void showFilterBottomSheet({context, isDelay = false}) {
    isDelay
        ? Future.delayed(Duration(milliseconds: 500), () => _showFilterBottomSheet(context))
        : _showFilterBottomSheet(context);
  }

  Future<void> searchAdoption(String query, bool? newQuery) async {
    // if (query.length == 0) {
    //   emit(state.copyWith(
    //       status: SearchPetStatus.initial,
    //       searchResults: [],
    //       searchQuery: query,
    //       paginationData: PaginationData.initial()));
    //   debugPrint('empty: $query');
    //   return;
    // }
    bool isFirstSearch = state.status == SearchPetStatus.initial;
    bool isNewQuery = state.status == SearchPetStatus.newQuery;
    if (!isFirstSearch && !isNewQuery && state.paginationData.currentPage == state.paginationData.totalPages) {
      debugPrint('${state.paginationData.currentPage}');
      debugPrint('${state.paginationData.totalPages}');
      return;
    }
    emit(state.copyWith(status: SearchPetStatus.searching));
    EasyLoading.show();
    debugPrint([state.minPrice.toString(), state.maxPrice.toString()].toList().toString());
    try {
      if (query != state.searchQuery || newQuery == true) {
        final searchResults = await _petaminRepository.getAdoptPagination(
          page: 1,
          limit: 10,
          species: state.selectedSpecies.length > 0
              ? state.selectedSpecies.map((e) => e.toString().split('.').last).toList()
              : null,
          prices: [
            state.minPrice != '0' ? state.minPrice.toString() : '0',
            state.maxPrice != '0' ? state.maxPrice.toString() : '10000000000'
          ],
          query: query,
        );
        emit(state.copyWith(
            status: SearchPetStatus.newQuery,
            searchResults: searchResults.pets,
            searchQuery: query,
            paginationData: searchResults.pagination));
      } else {
        final searchResults = await _petaminRepository.getAdoptPagination(
          page: isFirstSearch ? 1 : state.paginationData.currentPage + 1,
          limit: 10,
          species: state.selectedSpecies.length > 0
              ? state.selectedSpecies.map((e) => e.toString().split('.').last).toList()
              : null,
          prices: [
            state.minPrice != '0' ? state.minPrice.toString() : '0',
            state.maxPrice != '0' ? state.maxPrice.toString() : '10000000000'
          ],
          query: query,
        );
        emit(state.copyWith(
            status: SearchPetStatus.success,
            searchResults: [
              ...state.searchResults,
              ...searchResults.pets,
            ],
            searchQuery: query,
            paginationData: searchResults.pagination));
      }
    } catch (e) {
      emit(state.copyWith(status: SearchPetStatus.failure));
    }
    EasyLoading.dismiss();
  }

  void _showFilterBottomSheet(context) {
    Timer? _debounce;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext btsContext) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 300,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.colors.superLightPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Filter',
                              style: CustomTextTheme.subtitle(btsContext),
                            ),
                            TextButton(
                                onPressed: () {
                                  resetFilter();
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Text('Reset',
                                    style: CustomTextTheme.subtitle(btsContext, textColor: AppTheme.colors.pink))),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: CustomTextTheme.subtitle(btsContext),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                            height: 30,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (contextLV, index) {
                                final species = speciesData.entries.elementAt(index).key;
                                return PetFilterItem(
                                  species: species,
                                  selected: isSpeciesSelected(species),
                                  onTap: () {
                                    selectSpecies(species);
                                    setState(() {});
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 8.0,
                                );
                              },
                              itemCount: speciesData.length,
                            )),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: CustomTextTheme.subtitle(btsContext),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: state.minPrice,
                                onChanged: (value) {
                                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                                  _debounce = Timer(const Duration(milliseconds: 800), () {
                                    // do something with query
                                    print('Searching............');
                                    if (value.isNotEmpty) {
                                      print('called');
                                      setMinPrice(value);
                                      setState(() {});
                                    }
                                  });
                                },
                                maxLength: 7,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppTheme.colors.white, width: 0.0),
                                      borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppTheme.colors.white, width: 0.0),
                                      borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                                  hintText: '0\$',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  fillColor: AppTheme.colors.white,
                                  filled: true,
                                  helperText: 'Min',
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                                  _debounce = Timer(const Duration(milliseconds: 800), () {
                                    // do something with query
                                    print('Searching............');
                                    if (value.isNotEmpty) {
                                      setMaxPrice(value);
                                      setState(() {});
                                    }
                                  });
                                },
                                maxLength: 7,
                                initialValue: state.maxPrice,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppTheme.colors.white, width: 0.0),
                                      borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppTheme.colors.white, width: 0.0),
                                      borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                                  hintText: '0\$',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  fillColor: AppTheme.colors.white,
                                  filled: true,
                                  helperText: 'Max',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
