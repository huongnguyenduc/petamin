import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/profile/widgets/avatar.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:petamin_repository/petamin_repository.dart';

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileInfoCubit(context.read<PetaminRepository>())..getProfile(),
      child: ProfileInfoView(),
    );
  }
}

class ProfileInfoView extends StatefulWidget {
  const ProfileInfoView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileInfoView> createState() => _ProfileInfoViewState();
}

class _ProfileInfoViewState extends State<ProfileInfoView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController dayOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  void initState() {
    super.initState();
    nameController.text = ' ';
    bioController.text = ' ';
    addressController.text = ' ';
    phoneController.text = '          ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.mediumGrey,
      appBar: AppBar(
        title: Text('Profile Information'),
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
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) =>
                      previous.avatar != current.avatar ||
                      previous.avatarUrl != current.avatarUrl,
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => context
                          .read<ProfileInfoCubit>()
                          .selectProfileImage(ImageSource.gallery),
                      child: state.avatar != null
                          ? Container(
                              height: 102.0,
                              width: 102.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: FileImage(state.avatar!),
                                      fit: BoxFit.cover)),
                            )
                          : state.avatarUrl.isNotEmpty
                              ? SquaredAvatar(photo: state.avatarUrl)
                              : Container(
                                  height: 130.0,
                                  width: 130.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.colors.lightPink),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppTheme.colors.pink,
                                    size: 28.0,
                                  ),
                                ),
                    );
                  },
                ),
                SizedBox(
                  height: 32.0,
                ),
                BlocListener<ProfileInfoCubit, ProfileInfoState>(
                  listener: (context, state) =>
                      nameController.text = state.name,
                  child: TextFormField(
                    controller: nameController,
                    style: CustomTextTheme.body2(context),
                    decoration: InputDecoration(
                      errorText: nameController.value.text.isEmpty
                          ? 'Name is required'
                          : null,
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
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocListener<ProfileInfoCubit, ProfileInfoState>(
                  listener: (context, state) => bioController.text = state.bio,
                  child: TextFormField(
                    controller: bioController,
                    style: CustomTextTheme.body2(context),
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
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocListener<ProfileInfoCubit, ProfileInfoState>(
                  listener: (context, state) => dayOfBirthController.text =
                      DateFormat("dd/MM/yyyy")
                          .format(DateTime.parse(state.dayOfBirth)),
                  child: TextFormField(
                    controller: dayOfBirthController,
                    style: CustomTextTheme.body2(context),
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateFormat("dd/MM/yyyy")
                            .parse(dayOfBirthController.text),
                        firstDate: DateTime(1969),
                        lastDate: DateTime(2025),
                      );
                      if (picked != null && picked != dayOfBirthController.text)
                        dayOfBirthController.text =
                            DateFormat("dd/MM/yyyy").format(picked);
                      // context
                      //     .read<ProfileInfoCubit>()
                      //     .updateDayOfBirth(picked.toString());
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: AppTheme.colors.green,
                      ),
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
                      labelText: 'Day of Birth',
                      labelStyle: CustomTextTheme.body2(context,
                          textColor: AppTheme.colors.lightGreen),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocListener<ProfileInfoCubit, ProfileInfoState>(
                  listener: (context, state) =>
                      addressController.text = state.address,
                  child: TextFormField(
                    controller: addressController,
                    style: CustomTextTheme.body2(context),
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
                      labelText: 'Address',
                      labelStyle: CustomTextTheme.body2(context,
                          textColor: AppTheme.colors.lightGreen),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocListener<ProfileInfoCubit, ProfileInfoState>(
                  listener: (context, state) =>
                      phoneController.text = state.phoneNumber,
                  child: TextFormField(
                    controller: phoneController,
                    style: CustomTextTheme.body2(context),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: phoneController.value.text.length != 10 
                          ? 'Phone number must be 10 digits'
                          : null,
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
                      labelText: 'Phone number',
                      labelStyle: CustomTextTheme.body2(context,
                          textColor: AppTheme.colors.lightGreen),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return TextFormField(
                      key: UniqueKey(),
                      // onChanged: (name) =>
                      //     context.read<ProfileInfoCubit>().updateName(name),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.email,
                      enabled: false,
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
                        labelText: 'Email',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                    );
                  },
                ),
              ]),
              BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                // buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
                  return
                      // state.status.isSubmissionInProgress
                      //     ? const CircularProgressIndicator()
                      // :
                      ElevatedButton.icon(
                    key: UniqueKey(),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size.fromHeight(40),
                        primary: AppTheme.colors.pink,
                        onSurface: AppTheme.colors.pink),
                    onPressed: () => {
                      context.read<ProfileInfoCubit>().updateProfile(
                            name: nameController.text,
                            bio: bioController.text,
                            address: addressController.text,
                            phoneNumber: phoneController.text,
                            dayOfBirth: dayOfBirthController.text,
                          ),
                    },
                    icon: state.submitStatus.isLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Icon(Icons.feedback),
                    label: Text('Save', style: CustomTextTheme.label(context)),
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
