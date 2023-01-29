import 'dart:async';

import 'package:Petamin/home/home.dart';
import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/pet_adopt/view/pet_adopt_page.dart';
import 'package:Petamin/search/search.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petamin_repository/petamin_repository.dart';

class SearchPetPage extends StatelessWidget {
  const SearchPetPage(
      {Key? key,
      this.selectedSpecies,
      this.isShowFilter = false,
      this.isFocusSearchBar = false})
      : super(key: key);
  final Species? selectedSpecies;
  final bool? isShowFilter;
  final bool? isFocusSearchBar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) {
        if (selectedSpecies != null) {
          return SearchPetCubit(context.read<PetaminRepository>(),
              initSelectedSpecies: selectedSpecies)
            ..searchAdoption('i', true);
        }
        if (isShowFilter != null && isShowFilter == true) {
          return SearchPetCubit(context.read<PetaminRepository>())
            ..showFilterBottomSheet(context: context, isDelay: true);
        }

        if (isFocusSearchBar != null && isFocusSearchBar == true) {
          return SearchPetCubit(context.read<PetaminRepository>())
            ..requestFocusSearchBar();
        }

        return SearchPetCubit(context.read<PetaminRepository>())
          ..searchAdoption('i', true);
      },
      child: SearchPetView(),
    );
  }
}

class SearchPetView extends StatelessWidget {
  SearchPetView({
    Key? key,
  }) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    String _query = context.read<SearchPetCubit>().state.searchQuery;
    _onSearchChanged(String query) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 800), () {
        // do something with query
        _query = query;
        print("Searching............");
        context.read<SearchPetCubit>().searchAdoption(query, null);
      });
    }

    _scrollListener() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        print("reach the bottom");
        if (_query.isEmpty) return;
        context.read<SearchPetCubit>().searchAdoption(_query, null);
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        print("reach the top");
      }
    }

    _scrollController.addListener(_scrollListener);

    return SafeArea(
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.colors.superLightPurple,
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppTheme.colors.green,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    onChanged: _onSearchChanged,
                    focusNode:
                        context.read<SearchPetCubit>().searchBarFocusNode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.colors.white, width: 0.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.colors.white, width: 0.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppTheme.colors.green,
                      ),
                      hintText: 'Search by name, breed',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      fillColor: AppTheme.colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<SearchPetCubit>()
                          .showFilterBottomSheet(context: context);
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/action=filter.svg',
                      color: AppTheme.colors.green,
                    ),
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8.0),
              ],
            ),
            SizedBox(height: 12),
            BlocBuilder<SearchPetCubit, SearchPetState>(
              buildWhen: (previous, current) =>
                  previous.selectedSpecies != current.selectedSpecies,
              builder: (context, state) {
                return state.selectedSpecies.length == 0
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          SizedBox(width: 16),
                          PetFilterItem(
                            species: Species.CAT,
                            onTap: () => context
                                .read<SearchPetCubit>()
                                .selectSpecies(Species.CAT),
                          ),
                          SizedBox(width: 8),
                          PetFilterItem(
                              species: Species.DOG,
                              onTap: () => context
                                  .read<SearchPetCubit>()
                                  .selectSpecies(Species.DOG)),
                          SizedBox(width: 8),
                          PetFilterItem(
                              species: Species.BIRD,
                              onTap: () => context
                                  .read<SearchPetCubit>()
                                  .selectSpecies(Species.BIRD)),
                          SizedBox(width: 8),
                          PetFilterItem(
                              species: Species.POCKET_PET,
                              onTap: () => context
                                  .read<SearchPetCubit>()
                                  .selectSpecies(Species.POCKET_PET)),
                          SizedBox(width: 16),
                        ]),
                      )
                    : Row(
                        children: [
                          SizedBox(width: 12),
                          Material(
                            color: Colors.transparent,
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppTheme.colors.white,
                              ),
                              child: InkWell(
                                onTap: () {
                                  context.read<SearchPetCubit>().resetFilter();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(Icons.clear)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 30,
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (contextLV, index) {
                                  return PetFilterItem(
                                    species: state.selectedSpecies[index],
                                    selected: true,
                                    onTap: () {
                                      context
                                          .read<SearchPetCubit>()
                                          .selectSpecies(
                                              state.selectedSpecies[index]);
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 8.0,
                                  );
                                },
                                itemCount: state.selectedSpecies.length,
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
            SizedBox(height: 12),
            // Create Grid View with 2 columns
            Expanded(
              child: BlocBuilder<SearchPetCubit, SearchPetState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.selectedSpecies != current.selectedSpecies,
                  builder: (context, state) {
                    if (state.searchResults.length == 0 &&
                        (state.status == SearchPetStatus.success ||
                            state.status == SearchPetStatus.newQuery)) {
                      return Center(
                          child: Text(
                        'No pets found',
                        style: TextStyle(
                            color: AppTheme.colors.green, fontSize: 16),
                      ));
                    }
                    return GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final pet = state.searchResults[index];
                        return InkWell(
                            onTap: () => {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (context) => PetAdoptPage(
                                                id: pet.petId ?? '',
                                                ownerId: pet.userId ?? '',
                                              )))
                                },
                            child: PetCard(
                              data: PetCardData(
                                petId: pet.petId ?? '',
                                adoptId: pet.id ?? '',
                                age: '${pet.pet?.year ?? '0'}',
                                name: pet.pet?.name ?? '',
                                photo: pet.pet?.avatarUrl ?? '',
                                breed: pet.pet?.breed ?? '',
                                sex: pet.pet?.gender ?? 'unknown',
                                price: pet.price ?? 0,
                                // ignore: todo
                              ), // TODO: Change to real data
                            ));
                      },
                      itemCount: state.searchResults.length,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class PetFilterItemData {
  final String iconAsset;
  final String name;
  final Color color;
  final String id;
  final Species species;

  PetFilterItemData({
    required this.id,
    required this.iconAsset,
    required this.name,
    required this.color,
    required this.species,
  });
}

var speciesData = {
  Species.CAT: PetFilterItemData(
    id: 'CAT',
    iconAsset: 'assets/icons/pet=cat.svg',
    name: 'Cat',
    color: AppTheme.colors.lightYellow,
    species: Species.CAT,
  ),
  Species.DOG: PetFilterItemData(
    id: 'DOG',
    iconAsset: 'assets/icons/pet=dog.svg',
    name: 'Dog',
    color: AppTheme.colors.lightPurple,
    species: Species.DOG,
  ),
  Species.BIRD: PetFilterItemData(
    id: 'BIRD',
    iconAsset: 'assets/icons/pet=bird.svg',
    name: 'Bird',
    color: AppTheme.colors.lightPink,
    species: Species.BIRD,
  ),
  Species.POCKET_PET: PetFilterItemData(
    id: 'POCKET_PET',
    iconAsset: 'assets/icons/pet=pocket.svg',
    name: 'Pocket Pet',
    color: AppTheme.colors.softGreen,
    species: Species.POCKET_PET,
  ),
};

class PetFilterItem extends StatelessWidget {
  const PetFilterItem(
      {Key? key,
      this.selected = false,
      required this.species,
      required this.onTap})
      : super(key: key);

  final bool selected;
  final Species species;

  // onTap
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final data = speciesData[species]!;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.colors.ultraLightGreen
              : AppTheme.colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              data.iconAsset,
              color: AppTheme.colors.green,
            ),
            SizedBox(width: 8),
            Text(data.name, style: TextStyle(color: AppTheme.colors.green)),
          ],
        ),
      ),
    );
  }
}
