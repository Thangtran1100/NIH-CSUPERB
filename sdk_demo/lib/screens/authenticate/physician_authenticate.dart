import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/physician_register.dart';
import 'package:sdk_demo/screens/authenticate/physician_sign_in.dart';

class PhysicianAuthenticate extends StatefulWidget {
  const PhysicianAuthenticate({super.key});

  @override
  State<PhysicianAuthenticate> createState() => _PhysicianAuthenticateState();
}

class _PhysicianAuthenticateState extends State<PhysicianAuthenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return PhysicianSignIn(toggleView: toggleView);
    } else {
      return PhysicianRegistration(toggleView: toggleView);
    }
  }
}
