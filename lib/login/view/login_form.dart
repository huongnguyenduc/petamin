import 'dart:ui';

import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Petamin/login/login.dart';
import 'package:Petamin/sign_up/sign_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2!,
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sign in',
                              style: CustomTextTheme.heading1(
                                  context, AppTheme.colors.green),
                            ),
                            const SizedBox(height: 28),
                            _EmailInput(),
                            const SizedBox(height: 14),
                            _PasswordInput(),
                            const SizedBox(height: 82),
                            _LoginButton(),
                            const SizedBox(height: 16),
                            _GoogleLoginButton(),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 20, child: _SignUpButton()),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            style: CustomTextTheme.label(context, AppTheme.colors.green),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppTheme.colors.pink, width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppTheme.colors.lightPurple, width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0))),
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'Invalid email' : null,
              labelStyle:
                  CustomTextTheme.label(context, AppTheme.colors.lightGreen),
            ));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          style: CustomTextTheme.label(context, AppTheme.colors.green),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colors.pink, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppTheme.colors.lightPurple, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password' : null,
            labelStyle:
                CustomTextTheme.label(context, AppTheme.colors.lightGreen),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final theme = Theme.of(context);
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    minimumSize: const Size.fromHeight(40),
                    primary: AppTheme.colors.pink,
                    onSurface: AppTheme.colors.pink),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: Text('Let me in',
                    style:
                        CustomTextTheme.label(context, AppTheme.colors.green)),
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: Text(
        'Sign in with Google',
        style: CustomTextTheme.label(context, Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        minimumSize: const Size.fromHeight(40),
        primary: AppTheme.colors.green,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
        key: const Key('loginForm_createAccount_flatButton'),
        text: TextSpan(
          text: "Don't have account yet? ",
          style: CustomTextTheme.label(context, Colors.grey),
          children: [
            TextSpan(
              text: "Sign up",
              style: CustomTextTheme.label(context, theme.primaryColor),
              recognizer: new TapGestureRecognizer()
                ..onTap =
                    () => Navigator.of(context).push<void>(SignUpPage.route()),
            )
          ],
        ));
  }
}
