// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCAVH7wJfR6ytDRdill5Ub6YyvVnH4vWuc',
    appId: '1:940536959050:web:8e20c0eaed3a1c57e256b3',
    messagingSenderId: '940536959050',
    projectId: 'petamin-firebase',
    authDomain: 'petamin-firebase.firebaseapp.com',
    storageBucket: 'petamin-firebase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbyoAI6Ym-cs8P2gqEMflpanpcTRXAlGI',
    appId: '1:940536959050:android:df9f5e4622a38d9de256b3',
    messagingSenderId: '940536959050',
    projectId: 'petamin-firebase',
    storageBucket: 'petamin-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDB9riLuuUPoGIwNMhrDd6dIUbm9meUQyA',
    appId: '1:940536959050:ios:0f5f03653bbf29dfe256b3',
    messagingSenderId: '940536959050',
    projectId: 'petamin-firebase',
    storageBucket: 'petamin-firebase.appspot.com',
    iosClientId: '940536959050-gt76rsfgemgl7ehija1u34g5pdmd26rg.apps.googleusercontent.com',
    iosBundleId: 'com.example.petamin',
  );
}