import 'package:Petamin/app/view/app.dart';
import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetSpecies extends StatelessWidget {
  const PetSpecies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Tell us what's\nyour pet's species?",
            style: CustomTextTheme.heading2(context, textColor: Colors.white),
          ),
        ),
        SizedBox(
          height: 64,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: species.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                              onTap: () => context
                                  .read<PetAddCubit>()
                                  .selectSpecies(species[index].species),
                              child:
                                  PetSpeciesType(petSpecies: species[index]));
                        }),
                  ),
                ),
                ElevatedButton(
                  key: const Key('next_property_raisedButton'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size.fromHeight(40),
                      primary: AppTheme.colors.pink,
                      onSurface: AppTheme.colors.pink),
                  onPressed: () => context.read<PetAddCubit>().nextStep(),
                  child: Text('Next to Gender',
                      style: CustomTextTheme.label(context)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PetSpeciesType extends StatelessWidget {
  const PetSpeciesType({Key? key, required this.petSpecies}) : super(key: key);

  final SpeciesDetail petSpecies;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<PetAddCubit, PetAddState>(
          buildWhen: (previous, current) => previous.species != current.species,
          builder: (context, state) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              width: 115.0,
              height: 115.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: state.species == petSpecies.species
                      ? Border.all(color: AppTheme.colors.purple, width: 3.0)
                      : null,
                  color: petSpecies.color,
                  image: DecorationImage(
                    image: petSpecies.image,
                  )),
            );
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          petSpecies.name,
          style: CustomTextTheme.heading4(context),
        )
      ],
    );
  }
}

class SpeciesDetail {
  const SpeciesDetail(
      {Key? key,
      required this.name,
      required this.image,
      required this.color,
      required this.species});

  final String name;
  final Color color;
  final ImageProvider<Object> image;
  final Species species;
}

final species = [
  SpeciesDetail(
      name: "Cat",
      image: AssetImage("assets/images/cat.png"),
      color: AppTheme.colors.lightPurple,
      species: Species.cat),
  SpeciesDetail(
      name: "Dog",
      image: AssetImage("assets/images/dog.png"),
      color: AppTheme.colors.lightYellow,
      species: Species.dog),
  SpeciesDetail(
      name: "Bird",
      image: AssetImage("assets/images/parrot.png"),
      color: AppTheme.colors.softGreen,
      species: Species.bird),
  SpeciesDetail(
      name: "Pocket Pet",
      image: AssetImage("assets/images/rabbit.png"),
      color: AppTheme.colors.lightPink,
      species: Species.pocketPet)
];
