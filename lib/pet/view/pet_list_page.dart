import 'package:flutter/material.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PetListPage());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Pet List Page"),
    );
  }
}
