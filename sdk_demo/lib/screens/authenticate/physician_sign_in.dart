import 'package:flutter/material.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/screens/physician/physisician_home.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';

class PhysicianSignIn extends StatefulWidget {
  final Function toggleView;

  const PhysicianSignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<PhysicianSignIn> createState() => _PhysicianSignIn();
}

class _PhysicianSignIn extends State<PhysicianSignIn> {
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

        if (!mounted) return;

        if (user != null) {
          if (!mounted) return;

          Navigator.of(context).pop(); // This dismisses the dialog
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PhysicianHome()),
          );

          // Stop loading
          setState(() => isLoading = false);
        } else {
          throw Exception(
              'Failed to sign in. Please check your email and password.');
        }
      } catch (e) {
        setState(() {
          error = e.toString();
          isLoading = false;
        });
      }
    }
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
            icon: const Icon(Icons.person, color: Colors.white),
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
                      child: const Text('Sign in'),
                      onPressed: _signIn,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Forgot Password?'),
                      onPressed: _resetPassword,
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
