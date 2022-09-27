import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/profile/widgets/avatar.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit(),
      child: ProfileInfoView(),
    );
  }
}

class ProfileInfoView extends StatelessWidget {
  const ProfileInfoView({
    Key? key,
  }) : super(key: key);

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
                SquaredAvatar(
                  photo:
                      "https://images.pexels.com/photos/13570394/pexels-photo-13570394.jpeg?auto=compress&cs=tinysrgb&w=200&lazy=load",
                ),
                SizedBox(
                  height: 32.0,
                ),
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (name) =>
                          context.read<ProfileInfoCubit>().updateName(name),
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
                  height: 8.0,
                ),
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) => previous.bio != current.bio,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (bio) =>
                          context.read<ProfileInfoCubit>().updateBio(bio),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.bio,
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
                  height: 8.0,
                ),
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) =>
                      previous.dayOfBirth != current.dayOfBirth,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (birth) => context
                          .read<ProfileInfoCubit>()
                          .updateDayOfBirth(birth),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.dayOfBirth,
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
                        labelText: 'Day of Birth',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) =>
                      previous.address != current.address,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (address) => context
                          .read<ProfileInfoCubit>()
                          .updateAddress(address),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.address,
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
                    );
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) =>
                      previous.phoneNumber != current.phoneNumber,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
                      onChanged: (phone) => context
                          .read<ProfileInfoCubit>()
                          .updatePhoneNumber(phone),
                      style: CustomTextTheme.body2(context),
                      initialValue: state.phoneNumber,
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
                        labelText: 'Phone number',
                        labelStyle: CustomTextTheme.body2(context,
                            textColor: AppTheme.colors.lightGreen),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: (context, state) {
                    return TextFormField(
                      key: const Key('profileForm_nameInput_textField'),
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
