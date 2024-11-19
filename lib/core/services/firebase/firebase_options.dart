import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3PiIXP_Diu6VNjYNTC-oLOg-4vsHFskw',
    appId: '1:776398497700:android:d6ac17cab96be69e03c331',
    messagingSenderId: '776398497700',
    projectId: 'pos-flutter-app',
    storageBucket: 'pos-flutter-app.appspot.com',
  );

// Add more options for other platforms if needed, for example:
// static const FirebaseOptions ios = FirebaseOptions(
//   apiKey: 'IOS-API-KEY',
//   appId: 'IOS-APP-ID',
//   messagingSenderId: 'IOS-MESSAGING-SENDER-ID',
//   projectId: 'IOS-PROJECT-ID',
//   storageBucket: 'IOS-STORAGE-BUCKET',
// );

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyC35ee3Zjt3AFVqRIUT_I1-_D1_RCmm36U",
      authDomain: "pos-flutter-app.firebaseapp.com",
      databaseURL: "https://pos-flutter-app-default-rtdb.asia-southeast1.firebasedatabase.app",
      projectId: "pos-flutter-app",
      storageBucket: "pos-flutter-app.appspot.com",
      messagingSenderId: "776398497700",
      appId: "1:776398497700:web:9a5b30e1f36fb5fc03c331",
      measurementId: "G-Z7R87BTQQF"
  );
}
