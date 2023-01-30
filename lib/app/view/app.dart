import 'package:Petamin/app/app.dart';
import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/app/cubit/socket_io/socket_io_cubit.dart';
import 'package:Petamin/call/cubit/call_cubit.dart';
import 'package:Petamin/call/view/call_screen.dart';
import 'package:Petamin/homeRoot/cubit/home_root_cubit.dart';
import 'package:Petamin/homeRoot/cubit/home_root_state.dart';
import 'package:Petamin/profile-info/cubit/profile_info_cubit.dart';
import 'package:Petamin/routes/routes.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:petamin_repository/petamin_repository.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({
    Key? key,
    required this.petaminRepository,
  }) : super(key: key);
  final PetaminRepository petaminRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => petaminRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AppSessionBloc(
                    petaminRepository: petaminRepository,
                  )),
          BlocProvider(create: (_) => CallCubit()),
        ],
        child: const App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => HomeRootCubit(context.read<PetaminRepository>())
          ..checkSession()
          ..initFcm(context),
      ),
      BlocProvider(
          create: (_) =>
              SocketIoCubit(appSessionBloc: context.read<AppSessionBloc>())
                ..initSocket()
                ..listenToAppSession()),
      BlocProvider(
          create: (context) =>
              ProfileInfoCubit(context.read<PetaminRepository>())
                ..getProfile()),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.define(),
      home: BlocConsumer<HomeRootCubit, HomeRootState>(
          listener: (context, state) {
        //Receiver Call States
        if (state is SuccessInComingCallState) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CallScreen(
                    isReceiver: true,
                    callModel: state.callModel,
                  )));
        }
      }, builder: (context, state) {
        return FlowBuilder<SessionStatus>(
          state:
              context.select((AppSessionBloc bloc) => bloc.state.sessionStatus),
          onGeneratePages: onGenerateAppViewPages,
        );
      }),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
