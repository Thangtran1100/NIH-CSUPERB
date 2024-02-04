import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sdk_demo/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sdk_demo/services/telematics_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyB030cIvoZdX6pmBI8kSStqQhgY-aUiS84',
              appId: '1:983823372361:android:18c74fd14c5f13e8326f98',
              messagingSenderId: '983823372361',
              projectId: 'backend-login-8b331'))
      : await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
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
