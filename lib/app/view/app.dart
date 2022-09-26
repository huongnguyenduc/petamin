import 'package:Petamin/call/cubit/call_cubit.dart';
import 'package:Petamin/home/cubit/home_cubit.dart';
import 'package:Petamin/homeRoot/cubit/home_root_cubit.dart';
import 'package:Petamin/routes/routes.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Petamin/app/app.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
     //final user = context.select((AppBloc bloc) => bloc.state.user);
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider( 
           create: (_) => AppBloc( authenticationRepository: _authenticationRepository,)
          ),
          BlocProvider(
          create: (_) => HomeRootCubit()..initFcm(context),
          ),
          BlocProvider(
          create: (_) => HomeCubit(),
          ),
          BlocProvider(create: (_) => CallCubit()),
        ],
         child: const AppView(),
      ),
      );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.define(),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
