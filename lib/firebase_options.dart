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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCLDY21OS3NcUqQY41EG5ouG71Pxr-dUyg',
    appId: '1:529055002647:web:616fe064aa9435a06eec52',
    messagingSenderId: '529055002647',
    projectId: 'eshop-59b65',
    authDomain: 'eshop-59b65.firebaseapp.com',
    storageBucket: 'eshop-59b65.appspot.com',
    measurementId: 'G-GWLQZ2HYM2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLElSWPQ_27gNFSsiSs5fDwfgdhK23u1k',
    appId: '1:529055002647:android:04a65f41de89bfbc6eec52',
    messagingSenderId: '529055002647',
    projectId: 'eshop-59b65',
    storageBucket: 'eshop-59b65.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAfE0TDQhykFKFMAB7v32fTQtNX_6b6p8',
    appId: '1:529055002647:ios:c0f344d26ed511cb6eec52',
    messagingSenderId: '529055002647',
    projectId: 'eshop-59b65',
    storageBucket: 'eshop-59b65.appspot.com',
    androidClientId: '529055002647-dl8mk39qde96orrlmhn0m9479ke59or8.apps.googleusercontent.com',
    iosClientId: '529055002647-fbc39aeo46tdrrrcq2tmfn126dq9cs76.apps.googleusercontent.com',
    iosBundleId: 'com.example.vendor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDAfE0TDQhykFKFMAB7v32fTQtNX_6b6p8',
    appId: '1:529055002647:ios:c0f344d26ed511cb6eec52',
    messagingSenderId: '529055002647',
    projectId: 'eshop-59b65',
    storageBucket: 'eshop-59b65.appspot.com',
    androidClientId: '529055002647-dl8mk39qde96orrlmhn0m9479ke59or8.apps.googleusercontent.com',
    iosClientId: '529055002647-fbc39aeo46tdrrrcq2tmfn126dq9cs76.apps.googleusercontent.com',
    iosBundleId: 'com.example.vendor',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLDY21OS3NcUqQY41EG5ouG71Pxr-dUyg',
    appId: '1:529055002647:web:27f95f95ec94fa566eec52',
    messagingSenderId: '529055002647',
    projectId: 'eshop-59b65',
    authDomain: 'eshop-59b65.firebaseapp.com',
    storageBucket: 'eshop-59b65.appspot.com',
    measurementId: 'G-N6JY6YK1Q1',
  );

}