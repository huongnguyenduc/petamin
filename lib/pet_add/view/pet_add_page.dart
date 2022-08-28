import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/pet_add/widgets/widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetAddPage extends StatelessWidget {
  const PetAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PetAddCubit(),
      child: const PetAddStep(),
    );
  }
}

class PetAddStep extends StatelessWidget {
  const PetAddStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.green,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo/petamin_logo_small.png',
                height: 40,
              )
            ],
          ),
          actions: [
            PreferredSize(
              preferredSize: Size.fromHeight(72),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<PetAddCubit, PetAddState>(
                    buildWhen: ((previous, current) =>
                        previous.currentStep != current.currentStep),
                    builder: (context, state) {
                      return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: Text(
                            state.currentStep.toString(),
                            key: ValueKey<int>(state.currentStep),
                            style: CustomTextTheme.heading3(context,
                                textColor: AppTheme.colors.yellow),
                          ));
                    },
                  ),
                  Text(
                    "/7",
                    style:
                        CustomTextTheme.label(context, textColor: Colors.white),
                  ),
                  SizedBox(
                    width: 20.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<PetAddCubit, PetAddState>(
        buildWhen: ((previous, current) =>
            previous.currentStep != current.currentStep),
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 750),
            switchInCurve: Curves.easeOutSine,
            switchOutCurve: Curves.easeInSine,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return new SlideTransition(
                  position: new Tween<Offset>(
                          end: Offset.zero, begin: const Offset(0.0, 1.6))
                      .animate(animation),
                  child: child);
            },
            child: _renderPetAddStep(state.currentStep),
          );
        },
      ),
    );
  }
}

Widget _renderPetAddStep(int currentStep) {
  switch (currentStep) {
    case 1:
      return PetName(
        key: Key("name_petAdd"),
      );
    case 2:
      return PetSpecies(
        key: Key("species_petAdd"),
      );
    case 3:
      return PetBreed(
        key: Key("breed_petAdd"),
      );
    case 4:
      return PetGender(key: Key("gender_petAdd"));
    case 5:
      return PetNeuter(key: Key("neuter_petAdd"));
    case 6:
      return PetAge(key: Key("age_petAdd"));
    case 7:
      return PetImage(
        key: Key("image_petAdd"),
      );
    default:
      return PetName(
        key: Key("name_petAdd"),
      );
  }
}
