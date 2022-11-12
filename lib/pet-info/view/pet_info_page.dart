import 'package:Petamin/pet_add/pet_add.dart';
import 'package:Petamin/pet_add/widgets/pet_species_step.dart';
import 'package:Petamin/pet_detail/cubit/pet_detail_cubit.dart';
import 'package:Petamin/pet_detail/cubit/pet_detail_state.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/profile/widgets/widgets.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart'
    as petamin_repository;
import 'package:petamin_repository/petamin_repository.dart';

class PetInfoPage extends StatelessWidget {
  const PetInfoPage({required this.pet, Key? key}) : super(key: key);
  final petamin_repository.Pet pet;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetDetailCubit(context.read<PetaminRepository>()),
      child: PetInfoView(
        pet: this.pet,
      ),
    );
  }
}

class PetInfoView extends StatefulWidget {
  const PetInfoView({
    required this.pet,
    Key? key,
  }) : super(key: key);
  final petamin_repository.Pet pet;

  @override
  State<PetInfoView> createState() => _PetInfoViewState();
}

class _PetInfoViewState extends State<PetInfoView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController breedController = TextEditingController();
   TextEditingController weightController = TextEditingController();
  void initState() {
    super.initState();
    nameController.text = widget.pet.name!;
    bioController.text = widget.pet.description!;
    breedController.text = widget.pet.breed!;
    weightController.text = widget.pet.weight!.toString();
  }

  @override
  Widget build(BuildContext context) {
    final numberRangeYear = Iterable<int>.generate(99 + 1).toList();
    final numberRangeMonth = Iterable<int>.generate(12).toList();
    var speciesController = widget.pet.species;
    var genderController = widget.pet.gender;
    var neuteredController = widget.pet.isNeuter;
    var yearController = widget.pet.year;
    var monthController = widget.pet.month;
    return Scaffold(
        backgroundColor: AppTheme.colors.mediumGrey,
        appBar: AppBar(
          title: Text('Pet Information'),
          
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          height: MediaQuery.of(context).size.height * 0.9,
          child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText2!,
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(children: [
                            SquaredAvatar(
                              photo: widget.pet.avatarUrl ??
                                  "https://images.pexels.com/photos/7752793/pexels-photo-7752793.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&dpr=1",
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            TextFormField(
                              controller: nameController,
                              style: CustomTextTheme.body2(context),
                              decoration: InputDecoration(
                                fillColor: AppTheme.colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.pink,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.lightPurple,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                helperText: '',
                                labelText: 'Name',
                                labelStyle: CustomTextTheme.body2(context,
                                    textColor: AppTheme.colors.lightGreen),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            TextFormField(
                              controller: bioController,
                              style: CustomTextTheme.body2(context),
                              decoration: InputDecoration(
                                fillColor: AppTheme.colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.pink,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.lightPurple,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                helperText: '',
                                labelText: 'Bio',
                                labelStyle: CustomTextTheme.body2(context,
                                    textColor: AppTheme.colors.lightGreen),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                fillColor: AppTheme.colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.pink,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.lightPurple,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                helperText: '',
                                labelText: 'Species',
                                labelStyle: CustomTextTheme.body2(context,
                                    textColor: AppTheme.colors.lightGreen),
                              ),
                              style: CustomTextTheme.body2(context),
                              items: species
                                  .map((SpeciesDetail speciesDetail) =>
                                      DropdownMenuItem<String>(
                                        value:  speciesDetail.id,
                                        child: Text(speciesDetail.name),
                                      ))
                                  .toList(),
                              value: widget.pet.species,
                              onChanged: (selectedSpecies) => {
                                speciesController = selectedSpecies!,
                              },
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            TextFormField(
                              controller: breedController,
                              style: CustomTextTheme.body2(context),
                              decoration: InputDecoration(
                                fillColor: AppTheme.colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.pink,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.lightPurple,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                helperText: '',
                                labelText: 'Breed',
                                labelStyle: CustomTextTheme.body2(context,
                                    textColor: AppTheme.colors.lightGreen),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      fillColor: AppTheme.colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.colors.pink,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppTheme.colors.lightPurple,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      helperText: '',
                                      labelText: 'Gender',
                                      labelStyle: CustomTextTheme.body2(context,
                                          textColor:
                                              AppTheme.colors.lightGreen),
                                    ),
                                    style: CustomTextTheme.body2(context),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "MALE",
                                        child: Text("Male"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "FEMALE",
                                        child: Text("Female"),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "OTHER",
                                        child: Text("Unknown"),
                                      ),
                                    ].toList(),
                                    value: widget.pet.gender,
                                    onChanged: (selectedGender) =>
                                        {genderController = selectedGender!},
                                    //   );
                                    // },
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField<bool>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      fillColor: AppTheme.colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.colors.pink,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppTheme.colors.lightPurple,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      helperText: '',
                                      labelText: 'Neutered',
                                      labelStyle: CustomTextTheme.body2(context,
                                          textColor:
                                              AppTheme.colors.lightGreen),
                                    ),
                                    style: CustomTextTheme.body2(context),
                                    items: [
                                      DropdownMenuItem<bool>(
                                        value: true,
                                        child: Text("Yes"),
                                      ),
                                      DropdownMenuItem<bool>(
                                        value: false,
                                        child: Text("No"),
                                      )
                                    ].toList(),
                                    value: widget.pet.isNeuter ?? false,
                                    onChanged: (selectedNeuter) =>
                                        {neuteredController = selectedNeuter!},
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
                                  child: DropdownButtonFormField<int>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      fillColor: AppTheme.colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.colors.pink,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppTheme.colors.lightPurple,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      helperText: '',
                                      labelText: 'Year',
                                      labelStyle: CustomTextTheme.body2(context,
                                          textColor:
                                              AppTheme.colors.lightGreen),
                                    ),
                                    style: CustomTextTheme.body2(context),
                                    menuMaxHeight: 200.0,
                                    items: numberRangeYear
                                        .map((year) => DropdownMenuItem<int>(
                                            value: year,
                                            child: Text(year.toString())))
                                        .toList(),
                                    value: widget.pet.year,
                                    onChanged: (year) =>
                                        {yearController = year!},
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      fillColor: AppTheme.colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.colors.pink,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppTheme.colors.lightPurple,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0))),
                                      helperText: '',
                                      labelText: 'Month',
                                      labelStyle: CustomTextTheme.body2(context,
                                          textColor:
                                              AppTheme.colors.lightGreen),
                                    ),
                                    style: CustomTextTheme.body2(context),
                                    menuMaxHeight: 200.0,
                                    items: numberRangeMonth
                                        .map((month) => DropdownMenuItem<int>(
                                            value: month,
                                            child: Text(month.toString())))
                                        .toList(),
                                    value: widget.pet.month,
                                    onChanged: (month) =>
                                        {monthController = month!},
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: weightController,
                              style: CustomTextTheme.body2(context),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]')),
                              ],
                              decoration: InputDecoration(
                                fillColor: AppTheme.colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.pink,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.colors.lightPurple,
                                        width: 2.0),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0))),
                                helperText: '',
                                labelText: 'Weight (Kg)',
                                labelStyle: CustomTextTheme.body2(context,
                                    textColor: AppTheme.colors.lightGreen),
                              ),
                            ),
                          ]),
                          BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                            // buildWhen: (previous, current) => previous.status != current.status,
                            builder: (context, state) {
                              return ElevatedButton(
                                key: const Key(
                                    'loginForm_continue_raisedButton'),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    minimumSize: const Size.fromHeight(40),
                                    primary: AppTheme.colors.pink,
                                    onSurface: AppTheme.colors.pink),
                                onPressed: () => {
          
                                   context.read<PetDetailCubit>().updatePet(pet: 
                                   Pet(
                                    id: widget.pet.id.toString(),
                                    name: nameController.text,
                                    description: bioController.text,
                                    species: speciesController.toString(),
                                    gender: genderController,
                                    breed: breedController.text,
                                    month: monthController,
                                    year: yearController,
                                    isNeuter: neuteredController,
                                    isAdopting: widget.pet.isAdopting,
                                    photos: [],
                                    weight: weightController.text.length > 0 ? double.tryParse(weightController.text) : 0,
                                    avatarUrl: widget.pet.avatarUrl, )) 
                                },
                                child: Text('Save',
                                    style: CustomTextTheme.label(context)),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
        ));
  }
}
