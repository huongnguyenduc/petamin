import 'package:Petamin/home/cubit/home_cubit.dart';
import 'package:Petamin/landing/landing.dart';
import 'package:Petamin/routes/navigator_routes.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:authentication_repository/src/models/user.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Petamin/app/app.dart';
import 'package:Petamin/home/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: FlowBuilder<HomeState>(
        state: context.select((HomeCubit cubit) => cubit.state),
        onGeneratePages: onGenerateAppViewWindows,
      ),
      bottomNavigationBar: CustomNavigator(),
    );
  }
}
