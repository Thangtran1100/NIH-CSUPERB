import 'package:flutter/material.dart';
import 'package:sdk_demo/services/telematics_service.dart'; // Ensure this is the correct path

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String deviceToken = '';

  void _login() async {
    final TelematicsService _loginService = TelematicsService();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _loginService.loginWithDeviceToken(deviceToken);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Device Token'),
                onSaved: (value) => deviceToken = value!,
                validator: (value) => value!.isEmpty ? 'Enter Device Token' : null,
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
