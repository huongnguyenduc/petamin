import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/pet_add/widgets/pet_species_step.dart';
import 'package:Petamin/profile/widgets/widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetInfoPage extends StatelessWidget {
  const PetInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetAddCubit(),
      child: PetInfoView(),
    );
    ;
  }
}

class PetInfoView extends StatelessWidget {
  const PetInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.mediumGrey,
      appBar: AppBar(
        title: Text('Pet Information'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(children: [
                SquaredAvatar(
                  photo:
                      "https://images.pexels.com/photos/7752793/pexels-photo-7752793.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&dpr=1",
                ),
                SizedBox(
                  height: 4.0,
                ),
                BlocBuilder<PetAddCubit, PetAddState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (name) =>
                          context.read<PetAddCubit>().nameChanged(name),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.name,
                      decoration: InputDecoration(
                        fillColor: AppTheme.colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.pink, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.lightPurple, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        helperText: '',
                        labelText: 'Name',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 4.0,
                ),
                BlocBuilder<PetAddCubit, PetAddState>(
                  buildWhen: (previous, current) =>
                      previous.description != current.description,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (description) => context
                          .read<PetAddCubit>()
                          .descriptionChanged(description),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.description,
                      decoration: InputDecoration(
                        fillColor: AppTheme.colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.pink, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.lightPurple, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        helperText: '',
                        labelText: 'Bio',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 4.0,
                ),
                BlocBuilder<PetAddCubit, PetAddState>(
                  buildWhen: (previous, current) =>
                      previous.species != current.species,
                  builder: (context, state) {
                    return DropdownButtonFormField<Species>(
                      decoration: InputDecoration(
                        fillColor: AppTheme.colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.pink, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.lightPurple, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        helperText: '',
                        labelText: 'Species',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                      style: CustomTextTheme.body2(context),
                      items: species
                          .map((SpeciesDetail speciesDetail) =>
                              DropdownMenuItem<Species>(
                                value: speciesDetail.species,
                                child: Text(speciesDetail.name),
                              ))
                          .toList(),
                      value: (state.species) != Species.unselected
                          ? state.species
                          : Species.cat,
                      onChanged: (selectedSpecies) => context
                          .read<PetAddCubit>()
                          .selectSpecies(selectedSpecies!),
                    );
                  },
                ),
                SizedBox(
                  height: 4.0,
                ),
                BlocBuilder<PetAddCubit, PetAddState>(
                  buildWhen: (previous, current) =>
                      previous.breed != current.breed,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (breed) =>
                          context.read<PetAddCubit>().breedChanged(breed),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.breed,
                      decoration: InputDecoration(
                        fillColor: AppTheme.colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.pink, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.lightPurple, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        helperText: '',
                        labelText: 'Breed',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BlocBuilder<PetAddCubit, PetAddState>(
                        buildWhen: (previous, current) =>
                            previous.gender != current.gender,
                        builder: (context, state) {
                          return DropdownButtonFormField<Gender>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: AppTheme.colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.pink, width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.lightPurple,
                                      width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              helperText: '',
                              labelText: 'Gender',
                              labelStyle: CustomTextTheme.body2(context,
                                  textColor: AppTheme.colors.lightGreen),
                            ),
                            style: CustomTextTheme.body2(context),
                            items: [
                              DropdownMenuItem<Gender>(
                                value: Gender.male,
                                child: Text("Male"),
                              ),
                              DropdownMenuItem<Gender>(
                                value: Gender.female,
                                child: Text("Female"),
                              )
                            ].toList(),
                            value: (state.gender) != Gender.unknown
                                ? state.gender
                                : Gender.male,
                            onChanged: (selectedGender) => context
                                .read<PetAddCubit>()
                                .selectGender(selectedGender!),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                      child: BlocBuilder<PetAddCubit, PetAddState>(
                        buildWhen: (previous, current) =>
                            previous.neutered != current.neutered,
                        builder: (context, state) {
                          return DropdownButtonFormField<Neutered>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: AppTheme.colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.pink, width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.lightPurple,
                                      width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              helperText: '',
                              labelText: 'Neutered',
                              labelStyle: CustomTextTheme.body2(context,
                                  textColor: AppTheme.colors.lightGreen),
                            ),
                            style: CustomTextTheme.body2(context),
                            items: [
                              DropdownMenuItem<Neutered>(
                                value: Neutered.yes,
                                child: Text("Yes"),
                              ),
                              DropdownMenuItem<Neutered>(
                                value: Neutered.no,
                                child: Text("No"),
                              )
                            ].toList(),
                            value: (state.neutered) != Neutered.unknown
                                ? state.neutered
                                : Neutered.no,
                            onChanged: (selectedNeuter) => context
                                .read<PetAddCubit>()
                                .selectNeuter(selectedNeuter!),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BlocBuilder<PetAddCubit, PetAddState>(
                        buildWhen: (previous, current) =>
                            previous.year != current.year,
                        builder: (context, state) {
                          final numberRange =
                              Iterable<int>.generate(99 + 1).toList();
                          return DropdownButtonFormField<int>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: AppTheme.colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.pink, width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.lightPurple,
                                      width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              helperText: '',
                              labelText: 'Year',
                              labelStyle: CustomTextTheme.body2(context,
                                  textColor: AppTheme.colors.lightGreen),
                            ),
                            style: CustomTextTheme.body2(context),
                            items: numberRange
                                .map((year) => DropdownMenuItem<int>(
                                    value: year, child: Text(year.toString())))
                                .toList(),
                            value: state.year,
                            onChanged: (year) =>
                                context.read<PetAddCubit>().selectYear(year!),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                      child: BlocBuilder<PetAddCubit, PetAddState>(
                        buildWhen: (previous, current) =>
                            previous.month != current.month,
                        builder: (context, state) {
                          final numberRange =
                              Iterable<int>.generate(12).toList();
                          return DropdownButtonFormField<int>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: AppTheme.colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.pink, width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.colors.lightPurple,
                                      width: 2.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0))),
                              helperText: '',
                              labelText: 'Month',
                              labelStyle: CustomTextTheme.body2(context,
                                  textColor: AppTheme.colors.lightGreen),
                            ),
                            style: CustomTextTheme.body2(context),
                            items: numberRange
                                .map((month) => DropdownMenuItem<int>(
                                    value: month,
                                    child: Text(month.toString())))
                                .toList(),
                            value: state.month,
                            onChanged: (month) =>
                                context.read<PetAddCubit>().selectMonth(month!),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BlocBuilder<PetAddCubit, PetAddState>(
                  buildWhen: (previous, current) =>
                      previous.fractionalWeight != current.fractionalWeight,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (description) => context
                          .read<PetAddCubit>()
                          .descriptionChanged(description),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.description,
                      decoration: InputDecoration(
                        fillColor: AppTheme.colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.pink, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.colors.lightPurple, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0))),
                        helperText: '',
                        labelText: 'Bio',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                    );
                  },
                ),
              ]),
              BlocBuilder<PetAddCubit, PetAddState>(
                // buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  return
                      // state.status.isSubmissionInProgress
                      //     ? const CircularProgressIndicator()
                      // :
                      ElevatedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size.fromHeight(40),
                        primary: AppTheme.colors.pink,
                        onSurface: AppTheme.colors.pink),
                    onPressed: () => {},
                    // onPressed: state.status.isValidated
                    //     ? () => context.read<LoginCubit>().logInWithCredentials()
                    //     : null,
                    child: Text('Save', style: CustomTextTheme.label(context)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
