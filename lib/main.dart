import 'package:petamin_repository/petamin_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:Petamin/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  final petaminRepository = await PetaminRepository.create();

  runApp(App(petaminRepository: petaminRepository));
}
