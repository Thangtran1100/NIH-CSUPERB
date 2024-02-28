import 'package:flutter/material.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class UpdateCredentials extends StatefulWidget {
  @override
  _UpdateCredentialsState createState() => _UpdateCredentialsState();
}

class _UpdateCredentialsState extends State<UpdateCredentials> {
  final _formKey = GlobalKey<FormState>();
  String _newEmail = '';
  String _newPassword = '';
  final UnifiedAuthService _authService = UnifiedAuthService();
  bool _isUpdatingEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Credentials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_isUpdatingEmail)
                TextFormField(
                  decoration: InputDecoration(labelText: 'New Email'),
                  validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                  onSaved: (value) => _newEmail = value!,
                ),
              if (!_isUpdatingEmail)
                TextFormField(
                  decoration: InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters long' : null,
                  onSaved: (value) => _newPassword = value!,
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _isUpdatingEmail = true),
                    child: Text('Change Email'),
                    style: ElevatedButton.styleFrom(
                      primary: _isUpdatingEmail ? Colors.blue : Colors.grey,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _isUpdatingEmail = false),
                    child: Text('Change Password'),
                    style: ElevatedButton.styleFrom(
                      primary: !_isUpdatingEmail ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_isUpdatingEmail && _newEmail.isNotEmpty) {
                      _authService.changeEmail(_newEmail).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email updated successfully')));
                      }).catchError((error) {
                        String errorMessage = "Failed to update email";
                        if (error is FirebaseAuthException) {
                          errorMessage += ": ${error.message}";
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
                      });
                    } else if (!_isUpdatingEmail && _newPassword.isNotEmpty) {
                      _authService.changePassword(_newPassword).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated successfully')));
                      }).catchError((error) {
                        String errorMessage = "Failed to update password";
                        if (error is FirebaseAuthException) {
                          errorMessage += ": ${error.message}";
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
                      });
                    }
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
