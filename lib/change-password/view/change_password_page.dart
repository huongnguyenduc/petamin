import 'package:Petamin/change-password/change_password.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ChangePasswordCubit(petaminRepository: context.read<PetaminRepository>()),
        child: ChangePasswordView());
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.mediumGrey,
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  style: CustomTextTheme.body2(context),
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: AppTheme.colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colors.pink, width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colors.lightPurple, width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                    helperText: '',
                    labelText: 'Old Password',
                    labelStyle: CustomTextTheme.body2(context, textColor: AppTheme.colors.lightGreen),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  obscureText: true,
                  controller: _newPasswordController,
                  style: CustomTextTheme.body2(context),
                  decoration: InputDecoration(
                    fillColor: AppTheme.colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colors.pink, width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colors.lightPurple, width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(16.0))),
                    helperText: '',
                    labelText: 'New Password',
                    labelStyle: CustomTextTheme.body2(context, textColor: AppTheme.colors.lightGreen),
                  ),
                ),
              ],
            ))),
            BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is ChangePasswordLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size.fromHeight(40),
                        primary: AppTheme.colors.pink,
                        onSurface: AppTheme.colors.pink),
                    onPressed: () {
                      context.read<ChangePasswordCubit>().changePassword(
                          oldPassword: _oldPasswordController.text, newPassword: _newPasswordController.text);
                    },
                    child: Text('Change Password'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
