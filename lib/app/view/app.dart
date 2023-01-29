import 'package:Petamin/app/app.dart';
import 'package:Petamin/call/cubit/call_cubit.dart';
import 'package:Petamin/home/cubit/home_cubit.dart';
import 'package:Petamin/homeRoot/cubit/home_root_cubit.dart';
import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/home/bloc/socket_bloc.dart';
import 'package:Petamin/routes/routes.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required PetaminRepository petaminRepository,
  }) : _petaminRepository = petaminRepository;
  final PetaminRepository _petaminRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _petaminRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AppSessionBloc(
                    petaminRepository: _petaminRepository,
                  )),
          BlocProvider(
            create: (context) =>
                HomeRootCubit(context.read<PetaminRepository>())
                  ..checkSession()
                  ..initFcm(context),
          ),
          BlocProvider<ProfileInfoCubit>(
            create: (context) =>
                ProfileInfoCubit(context.read<PetaminRepository>())
                  ..checkSession()
                  ..getProfile(),
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
      home: FlowBuilder<SessionStatus>(
        state:
            context.select((AppSessionBloc bloc) => bloc.state.sessionStatus),
        onGeneratePages: onGenerateAppViewPages,
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
