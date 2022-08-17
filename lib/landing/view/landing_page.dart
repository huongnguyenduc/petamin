import 'package:Petamin/app/app.dart';
import 'package:flutter/material.dart';
import 'package:Petamin/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LandingPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Avatar(photo: user.photo),
          const SizedBox(height: 4),
          Text(user.email ?? '', style: textTheme.headline6),
          const SizedBox(height: 4),
          Text(user.name ?? '', style: textTheme.headline5),
        ],
      ),
    );
  }
}
