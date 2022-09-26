import 'dart:convert';

import 'package:Petamin/services/fcm/firebase_notification_handler.dart';
import 'package:Petamin/shared/dio_helper.dart';
import 'package:Petamin/shared/network/cache_helper.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:Petamin/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await CacheHelper.init();

  await Firebase.initializeApp();
  DioHelper.init();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  //Handle FCM background
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  runApp(App(authenticationRepository: authenticationRepository));
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await CacheHelper.init();
  if (message.data['type'] == 'call') {
    Map<String, dynamic> bodyMap = jsonDecode(message.data['body']);
    await CacheHelper.saveData(
        key: 'terminateIncomingCallData', value: jsonEncode(bodyMap));
  }
  debugPrint('gettttttttttttttt noooooooooooooooooo');
  FirebaseNotifications.showNotification(
      title: message.data['title'],
      body: message.data['body'],
      type: message.data['type']);
}
