import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetNeuter extends StatelessWidget {
  const PetNeuter({
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
            "Is Tommy neuter?",
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
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NeuterItem(
                            neutered: Neutered.yes,
                          ),
                          SizedBox(
                            width: 48.0,
                          ),
                          NeuterItem(
                            neutered: Neutered.no,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 3.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: AppTheme.colors.green))),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<PetAddCubit>()
                                .selectNeuter(Neutered.unknown);
                            context.read<PetAddCubit>().nextStep();
                          },
                          child: Text(
                            "I don't know",
                            style: CustomTextTheme.label(context),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
                  BlocBuilder<PetAddCubit,PetAddState>(
                  buildWhen: (previous, current) => current.neutered != Neutered.unknown,
                  builder: (context, state) {
                  return ElevatedButton(
                  key: const Key('next_property_raisedButton'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size.fromHeight(40),
                      primary: state.neutered != Neutered.unknown ? AppTheme.colors.pink : AppTheme.colors.lightGrey,
                      onSurface: AppTheme.colors.pink),
                  onPressed: () => state.neutered != Neutered.unknown ? context.read<PetAddCubit>().nextStep() : null,
                  child: Text('Next to Age',
                      style: CustomTextTheme.label(context)),
                );}),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NeuterItem extends StatelessWidget {
  const NeuterItem({Key? key, required this.neutered}) : super(key: key);

  final Neutered neutered;

  String convertNeuterToString(Neutered neutered) {
    switch (neutered) {
      case Neutered.yes:
        return "Yes";
      case Neutered.no:
        return "No";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PetAddCubit>().selectNeuter(neutered),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<PetAddCubit, PetAddState>(
            buildWhen: (previous, current) =>
                previous.neutered != current.neutered,
            builder: (context, state) {
              return AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      color: state.neutered == neutered
                          ? AppTheme.colors.pink
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: state.neutered == neutered
                          ? null
                          : Border.all(
                              color: AppTheme.colors.lightBorder, width: 2.0)),
                  child: Text(
                    convertNeuterToString(neutered),
                    style: CustomTextTheme.subtitle(
                      context,
                      textColor: state.neutered == neutered
                          ? Colors.white
                          : AppTheme.colors.green,
                    ),
                  ));
            },
          ),
          SizedBox(
            height: 14.0,
          ),
        ],
      ),
    );
  }
}
