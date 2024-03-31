import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/patient_register.dart';
import 'package:sdk_demo/screens/authenticate/patient_sign_in.dart';
import 'package:sdk_demo/screens/patient/patient_home.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'package:sdk_demo/models/user.dart';

class PatientAuthenticate extends StatefulWidget {
  const PatientAuthenticate({super.key});

  @override
  State<PatientAuthenticate> createState() => _PatientAuthenticateState();
}

class _PatientAuthenticateState extends State<PatientAuthenticate> {
  bool showSignIn = true;
  final UnifiedAuthService _authService = UnifiedAuthService();

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  // This method will be passed down to the sign in and register widgets.
  void onAuthenticated(AppUser user) async {
    String role = await _authService.checkUserRole(user.uid!);
    if (role == 'Patient') {
      // If the user is a patient, navigate to the PatientHome
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    } else {
      // If the user is not a physician, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must log in with a Patient account.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return PatientSignIn(
        toggleView: toggleView
      );
    } else {
      return PatientRegistration(toggleView: toggleView);
    }
  }
}
