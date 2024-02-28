import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAk9910ZhjWPYEzRZbfqiy7brmhVjN0_QU',
              appId: '1:1087866779795:android:8f81bce241d4c66a05b566',
              messagingSenderId: '1087866779795',
              projectId: 'telematics-sample-cd2af'))
      : await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: UnifiedAuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Firebase App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
