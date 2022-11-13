import 'package:Petamin/home/home.dart';
import 'package:Petamin/landing/cubit/landing_cubit.dart';
import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/search/search.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPetPage extends StatelessWidget {
  const SearchPetPage({Key? key, this.selectedSpecies, this.isShowFilter = false, this.isFocusSearchBar = false})
      : super(key: key);
  final Species? selectedSpecies;
  final bool? isShowFilter;
  final bool? isFocusSearchBar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) {
        if (selectedSpecies != null) {
          return SearchPetCubit(initSelectedSpecies: selectedSpecies);
        }
        if (isShowFilter != null && isShowFilter == true) {
          return SearchPetCubit()..showFilterBottomSheet(context: context, isDelay: true);
        }

        if (isFocusSearchBar != null && isFocusSearchBar == true) {
          return SearchPetCubit()..requestFocusSearchBar();
        }

        return SearchPetCubit();
      },
      child: SearchPetView(),
    );
  }
}

class SearchPetView extends StatelessWidget {
  const SearchPetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    focusNode: context.read<SearchPetCubit>().searchBarFocusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.colors.white, width: 0.0),
                          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.colors.white, width: 0.0),
                          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppTheme.colors.green,
                      ),
                      hintText: 'Search pets',
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
                      context.read<SearchPetCubit>().showFilterBottomSheet(context: context);
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
              buildWhen: (previous, current) => previous.selectedSpecies != current.selectedSpecies,
              builder: (context, state) {
                return state.selectedSpecies.length == 0
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          SizedBox(width: 16),
                          PetFilterItem(species: Species.cat),
                          SizedBox(width: 8),
                          PetFilterItem(species: Species.dog),
                          SizedBox(width: 8),
                          PetFilterItem(species: Species.bird),
                          SizedBox(width: 8),
                          PetFilterItem(species: Species.pocketPet),
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
                                itemBuilder: (context, index) {
                                  return PetFilterItem(
                                    species: state.selectedSpecies[index],
                                    selected: true,
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
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return PetCard(
                    data: petsMock[index], // TODO: Change to real data
                  );
                },
                itemCount: petsMock.length, // TODO: Change to real data
              ),
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

  PetFilterItemData({
    required this.iconAsset,
    required this.name,
    required this.color,
  });
}

var speciesData = {
  Species.cat: PetFilterItemData(
    iconAsset: 'assets/icons/pet=cat.svg',
    name: 'Cat',
    color: AppTheme.colors.lightYellow,
  ),
  Species.dog: PetFilterItemData(
    iconAsset: 'assets/icons/pet=dog.svg',
    name: 'Dog',
    color: AppTheme.colors.lightPurple,
  ),
  Species.bird: PetFilterItemData(
    iconAsset: 'assets/icons/pet=bird.svg',
    name: 'Bird',
    color: AppTheme.colors.lightPink,
  ),
  Species.pocketPet: PetFilterItemData(
    iconAsset: 'assets/icons/pet=pocket.svg',
    name: 'Pocket Pet',
    color: AppTheme.colors.softGreen,
  ),
};

class PetFilterItem extends StatelessWidget {
  const PetFilterItem({Key? key, this.selected = false, required this.species, this.cubitContext}) : super(key: key);

  final bool selected;
  final Species species;
  final BuildContext? cubitContext;

  @override
  Widget build(BuildContext context) {
    final data = speciesData[species]!;
    return InkWell(
      onTap: () {
        // cubit select species
        (cubitContext ?? context).read<SearchPetCubit>().selectSpecies(species);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.colors.ultraLightGreen : AppTheme.colors.white,
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
