import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD9EfXuzQUSxJyHdB4PDGT2j-t19qXwA_I",
            authDomain: "sample-chat-app-jez69n.firebaseapp.com",
            projectId: "sample-chat-app-jez69n",
            storageBucket: "sample-chat-app-jez69n.appspot.com",
            messagingSenderId: "146094344291",
            appId: "1:146094344291:web:2831f02efff34943c71056"));
  } else {
    await Firebase.initializeApp();
  }
}
