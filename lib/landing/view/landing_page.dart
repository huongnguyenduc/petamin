import 'package:Petamin/app/app.dart';
import 'package:flutter/material.dart';
import 'package:Petamin/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LandingPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppSessionBloc bloc) => bloc.state.session);
    final textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(user.userId ?? '', style: textTheme.headline5),
        ],
      ),
    );
  }
}
