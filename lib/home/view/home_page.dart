import 'dart:convert';
import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/call/view/call_screen.dart';
import 'package:Petamin/routes/navigator_routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Petamin/home/home.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../data/models/call_model.dart';
import '../../shared/constants.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/shared_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  build(BuildContext context) { 
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
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   actions: <Widget>[
      //     IconButton(
      //       key: const Key('homePage_logout_iconButton'),
      //       icon: const Icon(Icons.exit_to_app),
      //       onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
      //     )
      //   ],
      // ),
      body: FlowBuilder<HomeState>(
        state: context.select((HomeCubit cubit) => cubit.state),
        onGeneratePages: onGenerateAppViewWindows,
      ),
      bottomNavigationBar: CustomNavigator(),
    );
  }
}
