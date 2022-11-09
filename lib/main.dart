import 'dart:convert';

import 'package:Petamin/app/app.dart';
import 'package:Petamin/services/fcm/firebase_notification_handler.dart';
import 'package:Petamin/shared/dio_helper.dart';
import 'package:Petamin/shared/network/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petamin_repository/petamin_repository.dart';

Future<void> main() async {
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
  DioHelper.init();

  // final authenticationRepository = AuthenticationRepository();
  // await authenticationRepository.user.first;
  //runApp(App(authenticationRepository: authenticationRepository));

  //Handle FCM background
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  final petaminRepository = await PetaminRepository.create();

  runApp(App(petaminRepository: petaminRepository));
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await CacheHelper.init();
  if (message.data['type'] == 'call') {
    Map<String, dynamic> bodyMap = jsonDecode(message.data['body']);
    await CacheHelper.saveData(key: 'terminateIncomingCallData', value: jsonEncode(bodyMap));
  }
  debugPrint('gettttttttttttttt noooooooooooooooooo');
  FirebaseNotifications.showNotification(
      title: message.data['title'], body: message.data['body'], type: message.data['type']);
}
