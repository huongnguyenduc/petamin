import 'package:Petamin/app/bloc/app_bloc.dart';
import 'package:Petamin/routes/routes.dart';
import 'package:Petamin/theme/app_theme.dart';
import 'package:petamin_repository/petamin_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Petamin/app/app.dart';

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
                  ))
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
    );
  }
}
