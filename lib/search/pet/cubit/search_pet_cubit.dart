import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/search/pet/search_pet.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_pet_state.dart';

class SearchPetCubit extends Cubit<SearchPetState> {
  final Species? initSelectedSpecies;

  final searchBarFocusNode = FocusNode();

  void requestFocusSearchBar() {
    searchBarFocusNode.requestFocus();
  }

  SearchPetCubit({this.initSelectedSpecies})
      : super(SearchPetState(selectedSpecies: initSelectedSpecies != null ? [initSelectedSpecies] : []));

  void selectSpecies(Species species) {
    if (isSpeciesSelected(species)) {
      emit(state.copyWith(selectedSpecies: state.selectedSpecies.where((element) => element != species).toList()));
    } else {
      emit(state.copyWith(selectedSpecies: [...state.selectedSpecies, species]));
    }
  }

  void setMinPrice(int minPrice) {
    emit(state.copyWith(minPrice: minPrice));
  }

  void setMaxPrice(int maxPrice) {
    emit(state.copyWith(maxPrice: maxPrice));
  }

  void resetFilter() {
    emit(state.copyWith(selectedSpecies: [], minPrice: 0, maxPrice: 0));
  }

  bool isSpeciesSelected(Species species) {
    return state.selectedSpecies.contains(species);
  }

  void showFilterBottomSheet({context, isDelay = false}) {
    isDelay
        ? Future.delayed(Duration(milliseconds: 500), () => _showFilterBottomSheet(context))
        : _showFilterBottomSheet(context);
  }

  void _showFilterBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext btsContext) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
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
              );
            },
          );
        });
  }
}
