import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/patient_register.dart';
import 'package:sdk_demo/screens/authenticate/patient_sign_in.dart';

class PatientAuthenticate extends StatefulWidget {
  const PatientAuthenticate({super.key});

  @override
  State<PatientAuthenticate> createState() => _PatientAuthenticateState();
}

class _PatientAuthenticateState extends State<PatientAuthenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return PatientSignIn(toggleView: toggleView);
    } else {
      return PatientRegistration(toggleView: toggleView);
    }
  }
}
