import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/physician_register.dart';
import 'package:sdk_demo/screens/authenticate/physician_sign_in.dart';
import 'package:sdk_demo/screens/physician/physician_home.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'package:sdk_demo/models/user.dart';

class PhysicianAuthenticate extends StatefulWidget {
  const PhysicianAuthenticate({super.key});

  @override
  State<PhysicianAuthenticate> createState() => _PhysicianAuthenticateState();
}

class _PhysicianAuthenticateState extends State<PhysicianAuthenticate> {
  bool showSignIn = true;
  final UnifiedAuthService _authService = UnifiedAuthService();

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  // This method will be passed down to the sign in and register widgets.
  void onAuthenticated(AppUser user) async {
    String role = await _authService.checkUserRole(user.uid!);
    if (role == 'Physician') {
      // If the user is a physician, navigate to the PhysicianHome
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PhysicianHome()),
        );
      }
    } else {
      // If the user is not a physician, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must log in with a Physician account.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return PhysicianSignIn(
        toggleView: toggleView,
        onSignIn: onAuthenticated, // Pass the authentication handler
      );
    } else {
      return PhysicianRegistration(toggleView: toggleView);
    }
  }
}
