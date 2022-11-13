import 'package:Petamin/home/home.dart';
import 'package:Petamin/routes/navigator_routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      resizeToAvoidBottomInset: false,
      body: FlowBuilder<HomeState>(
        state: context.select((HomeCubit cubit) => cubit.state),
        onGeneratePages: onGenerateAppViewWindows,
      ),
      bottomNavigationBar: CustomNavigator(),
    );
  }
}
