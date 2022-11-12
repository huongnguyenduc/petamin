import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetGender extends StatelessWidget {
  const PetGender({
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
            "What is\nTommy's gender?",
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
                          GenderItem(
                            icon: Icons.male_rounded,
                            gender: Gender.MALE,
                          ),
                          SizedBox(
                            width: 48.0,
                          ),
                          GenderItem(
                            icon: Icons.female_rounded,
                            gender: Gender.FEMALE,
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
                                .selectGender(Gender.OTHER);
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
                  buildWhen: (previous, current) => current.gender != Gender.OTHER,
                  builder: (context, state) {
                  return ElevatedButton(
                  key: const Key('next_property_raisedButton'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size.fromHeight(40),
                      primary: state.gender != Gender.OTHER ?AppTheme.colors.pink : AppTheme.colors.lightGrey,
                      onSurface: AppTheme.colors.pink),
                  onPressed: () => state.gender != Gender.OTHER ? context.read<PetAddCubit>().nextStep() : null,
                  child: Text('Next to Neuter',
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

class GenderItem extends StatelessWidget {
  const GenderItem({Key? key, required this.icon, required this.gender})
      : super(key: key);

  final IconData icon;
  final Gender gender;

  String convertGenderToString(Gender gender) {
    switch (gender) {
      case Gender.MALE:
        return "Male";
      case Gender.FEMALE:
        return "Female";
      default:
        return "Other";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PetAddCubit>().selectGender(gender),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<PetAddCubit, PetAddState>(
            buildWhen: (previous, current) => previous.gender != current.gender,
            builder: (context, state) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                    color: state.gender == gender
                        ? AppTheme.colors.pink
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: state.gender == gender
                        ? null
                        : Border.all(
                            color: AppTheme.colors.lightBorder, width: 2.0)),
                child: Icon(
                  icon,
                  size: 45.0,
                  color: state.gender == gender
                      ? Colors.white
                      : AppTheme.colors.green,
                ),
              );
            },
          ),
          SizedBox(
            height: 14.0,
          ),
          Text(
            convertGenderToString(gender),
            style: CustomTextTheme.subtitle(context),
          )
        ],
      ),
    );
  }
}
