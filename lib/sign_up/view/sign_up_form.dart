import 'package:Petamin/login/view/login_page.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:Petamin/theme/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Petamin/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
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
                              'Sign up',
                              style: CustomTextTheme.heading1(
                                  context, AppTheme.colors.green),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Sign up as pet owner',
                              style: CustomTextTheme.body2(
                                  context, AppTheme.colors.green),
                            ),
                            const SizedBox(height: 44),
                            _EmailInput(),
                            const SizedBox(height: 14),
                            _PasswordInput(),
                            const SizedBox(height: 14),
                            _ConfirmPasswordInput(),
                            const SizedBox(height: 16),
                            _SignUpButton(),
                            const SizedBox(height: 16),
                            // _GoogleLoginButton(),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 20, child: _SignInButton()),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colors.pink, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppTheme.colors.lightPurple, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            labelText: 'Email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
            labelStyle:
                CustomTextTheme.label(context, AppTheme.colors.lightGreen),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colors.pink, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppTheme.colors.lightPurple, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            labelText: 'Confirm password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'Passwords do not match'
                : null,
            labelStyle:
                CustomTextTheme.label(context, AppTheme.colors.lightGreen),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size.fromHeight(40),
                  primary: AppTheme.colors.green,
                  onSurface: AppTheme.colors.pink,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: Text(
                  'Let me in',
                  style: CustomTextTheme.label(context, AppTheme.colors.green),
                ),
              );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
        key: const Key('loginForm_createAccount_flatButton'),
        text: TextSpan(
          text: "Already have an account? ",
          style: CustomTextTheme.label(context, Colors.grey),
          children: [
            TextSpan(
              text: "Sign in",
              style: CustomTextTheme.label(context, theme.primaryColor),
              recognizer: new TapGestureRecognizer()
                ..onTap =
                    () => Navigator.of(context).push<void>(LoginPage.route()),
            )
          ],
        ));
  }
}
