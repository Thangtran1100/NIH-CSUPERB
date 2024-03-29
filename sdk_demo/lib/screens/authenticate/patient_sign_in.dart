import 'package:flutter/material.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/screens/patient/patient_home.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';

class PatientSignIn extends StatefulWidget {
  final Function toggleView;

  const PatientSignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<PatientSignIn> createState() => _PatientSignInState();
}

class _PatientSignInState extends State<PatientSignIn> {
  final UnifiedAuthService _auth = UnifiedAuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => isLoading = true);
        AppUser? user = await _auth.signInWithEmailAndPassword(email, password);

        // Check if the widget is still mounted before proceeding
        if (!mounted) return;

        if (user != null) {
          // Perform the role check after successful sign-in
          String role = await _auth.checkUserRole(user.uid!);

          // Check if the widget is still mounted before proceeding
          if (!mounted) return;

          if (role == 'Patient') {
            // Check if the widget is still mounted before proceeding
            if (!mounted) return;

            await _auth.getDeviceTokenForUser(user.uid);

            // Check if the widget is still mounted before proceeding
            if (!mounted) return;

            Navigator.of(context).pop(); // This dismisses any open dialogs
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const Home()), // Navigate to the patient home
            );
          } else if (role == 'Physician') {
            // If the role is Physician, but this sign-in method is for Patients,
            // you might want to show an error or redirect to the Physician sign-in page
            setState(() {
              isLoading = false;
              error = 'Physicians are not allowed to sign in here.';
            });
          } else {
            // Handle the case where the role is not recognized
            setState(() {
              isLoading = false;
              error = 'Your role is not recognized. Please contact support.';
            });
          }
        } else {
          setState(() {
            isLoading = false;
            error = 'Failed to sign in. Please check your email and password.';
          });
        }
      } catch (e) {
        setState(() {
          error = e.toString();
          isLoading = false;
        });
      }
    }
  }

  void _showSDKEnabledDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SDK Enabled'),
          content:
              const Text('The SDK has been enabled and tracking has started.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to handle password reset
  void _resetPassword() async {
    if (email.isNotEmpty) {
      try {
        await _auth.resetPassword(email);
        print('Password reset email sent to $email');
      } catch (e) {
        print('Failed to reset password: $e');
      }
    } else {
      setState(() {
        error = 'Please enter your email to reset the password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person_add, color: Colors.white),
            label:
                const Text('Register', style: TextStyle(color: Colors.white)),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? 'Enter a email' : null,
                      onChanged: (val) => setState(() => email = val),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Password'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a password' : null,
                      onChanged: (val) => setState(() => password = val),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: _signIn,
                      child: const Text('Sign in'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: _resetPassword,
                      child: const Text('Forgot Password?'),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
