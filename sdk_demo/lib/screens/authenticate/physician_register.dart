import 'package:flutter/material.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';

class PhysicianRegistration extends StatefulWidget {
  final Function toggleView;

  const PhysicianRegistration({super.key, required this.toggleView});

  @override
  State<PhysicianRegistration> createState() => _PhysicianRegistrationState();
}

class _PhysicianRegistrationState extends State<PhysicianRegistration> {
  final UnifiedAuthService _auth = UnifiedAuthService();
  final _formKey = GlobalKey<FormState>();

  // Fields for physician registration
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  String organizationName = '';
  String npi = ''; // National Provider Identifier
  String phone = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Physician Registration')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onSaved: (value) => firstName = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your first name' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onSaved: (value) => lastName = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your last name' : null,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Organization Name'),
                  onSaved: (value) => organizationName = value ?? '',
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your organization name'
                      : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'NPI (National Provider Identifier)'),
                  onSaved: (value) => npi = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your NPI' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone'),
                  onSaved: (value) => phone = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => email = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  onChanged: (value) => setState(() => password = value),
                  onSaved: (value) => password = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                ),
                TextFormField(
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState!.save();
                      dynamic result = await _auth.registerPhysician(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                        organizationName: organizationName,
                        npi: npi,
                        phone: phone,
                      );
                      if (result == null) {
                        setState(() =>
                            error = 'An error occurred during registration');
                      }
                      else
                      {
                        widget.toggleView();
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: const Text('Already have an account? Sign in here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
