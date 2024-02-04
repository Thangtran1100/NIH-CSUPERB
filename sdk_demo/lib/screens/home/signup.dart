// import 'package:flutter/material.dart';
// import 'package:sdk_demo/services/telematics_service.dart';

// class RegistrationForm extends StatefulWidget {
//   @override
//   _RegistrationFormState createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TelematicsService _registrationService = TelematicsService();

//   String firstName = '';
//   String lastName = '';
//   String nickname = '';
//   String phone = '';
//   String email = '';
//   String clientId = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Registration')),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'First Name'),
//                   onSaved: (value) => firstName = value ?? '',
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter your first name' : null,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Last Name'),
//                   onSaved: (value) => lastName = value ?? '',
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter your last name' : null,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Phone'),
//                   onSaved: (value) => phone = value ?? '',
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter your phone number' : null,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Email'),
//                   onSaved: (value) => email = value ?? '',
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter your email' : null,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Client ID'),
//                   onSaved: (value) => clientId = value ?? '',
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       _registrationService.registerUser(
//                         firstName: firstName,
//                         lastName: lastName,
//                         phone: phone,
//                         email: email,
//                         clientId: clientId,
//                       );
//                     }
//                   },
//                   child: Text('Register'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';

class RegistrationForm extends StatefulWidget {

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final UnifiedAuthService _auth = UnifiedAuthService(); // Use UnifiedAuthService
  final _formKey = GlobalKey<FormState>();

  // Add fields for telematics registration
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String phone = '';
  String clientId = ''; // Assume this is generated or input by the user as needed
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  onSaved: (value) => firstName = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your first name' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  onSaved: (value) => lastName = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your last name' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone'),
                  onSaved: (value) => phone = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => email = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  onSaved: (value) => password = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Client ID'),
                  onSaved: (value) => clientId = value ?? '',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState!.save();
        dynamic result = await _auth.registerUser(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          clientId: clientId,
        );
        if (result == null) {
          setState(() => error = 'An error occurred during registration');
        }
      }
    },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
