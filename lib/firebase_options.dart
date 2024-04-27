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
        return macos;
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
    apiKey: 'AIzaSyB_VB7jNAVnc_AXg0kt0C_Ph4mkj4YBycI',
    appId: '1:425747143474:web:8dfa6293cb76fd1ccb152b',
    messagingSenderId: '425747143474',
    projectId: 'dafa-98847',
    authDomain: 'dafa-98847.firebaseapp.com',
    storageBucket: 'dafa-98847.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    // apiKey: 'AIzaSyBVdCb6E_diHVhzBl5fDeNFG73o5g5t5Mw',
    // appId: '1:425747143474:android:19468153dfd38f2fcb152b',
    // messagingSenderId: '425747143474',
    // projectId: 'dafa-98847',
    // storageBucket: 'dafa-98847.appspot.com',
    apiKey: 'AIzaSyBVdCb6E_diHVhzBl5fDeNFG73o5g5t5Mw',
    appId: '1:425747143474:android:28d0cb89b44e1b8acb152b',
    messagingSenderId: '425747143474',
    projectId: 'dafa-98847',
    storageBucket: 'dafa-98847.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlw6gVmBGQlvb-g9BqAsJN-mbJ7HzaIYU',
    appId: '1:425747143474:ios:b80f747ccce20f0fcb152b',
    messagingSenderId: '425747143474',
    projectId: 'dafa-98847',
    storageBucket: 'dafa-98847.appspot.com',
    iosBundleId: 'com.example.dafa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAlw6gVmBGQlvb-g9BqAsJN-mbJ7HzaIYU',
    appId: '1:425747143474:ios:b80f747ccce20f0fcb152b',
    messagingSenderId: '425747143474',
    projectId: 'dafa-98847',
    storageBucket: 'dafa-98847.appspot.com',
    iosBundleId: 'com.example.dafa',
  );
}
