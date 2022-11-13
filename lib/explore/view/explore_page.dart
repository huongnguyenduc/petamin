import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ExplorePage());

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Explore Page'));
  }
}
