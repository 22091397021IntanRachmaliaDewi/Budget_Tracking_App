// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoxLIDgOsc9qogBT5GH7rPQ8uYLBnucYk',
    appId: '1:572185967063:android:1f1f944938da23fbccf392',
    messagingSenderId: '572185967063',
    projectId: 'budged-app',
    storageBucket: 'budged-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAttu2h3kjQUOIGb_7b7LtvH55LKjkHrNw',
    appId: '1:572185967063:ios:81da4db0e1857734ccf392',
    messagingSenderId: '572185967063',
    projectId: 'budged-app',
    storageBucket: 'budged-app.appspot.com',
    iosBundleId: 'com.example.budgetTrackingApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHr7m3NgIMhksbBeIqJN6buuuCDkvQ3r4',
    appId: '1:572185967063:web:277cd6283862ab20ccf392',
    messagingSenderId: '572185967063',
    projectId: 'budged-app',
    authDomain: 'budged-app.firebaseapp.com',
    storageBucket: 'budged-app.appspot.com',
    measurementId: 'G-JWR33L0THX',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAttu2h3kjQUOIGb_7b7LtvH55LKjkHrNw',
    appId: '1:572185967063:ios:81da4db0e1857734ccf392',
    messagingSenderId: '572185967063',
    projectId: 'budged-app',
    storageBucket: 'budged-app.appspot.com',
    iosBundleId: 'com.example.budgetTrackingApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHr7m3NgIMhksbBeIqJN6buuuCDkvQ3r4',
    appId: '1:572185967063:web:64f3af8df462a527ccf392',
    messagingSenderId: '572185967063',
    projectId: 'budged-app',
    authDomain: 'budged-app.firebaseapp.com',
    storageBucket: 'budged-app.appspot.com',
    measurementId: 'G-R2VDH49NDR',
  );

}