import 'package:flutter/material.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientRegistration extends StatefulWidget {
  final Function toggleView;

  const PatientRegistration({super.key, required this.toggleView});
  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  final UnifiedAuthService _auth = UnifiedAuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  DateTime selectedDate = DateTime.now();
  String birthday = '';
  List<String> genders = ['Male', 'Female', 'Other'];
  String gender = '';
  String physicianName = '';
  String? physicianUid;
  String error = '';

  List<DropdownMenuItem<String>> physicianItems = [];

  @override
void initState() {
  super.initState();
  physicianUid = null; 
  anonymousSignInAndLoadPhysicians();
  birthday = DateFormat.yMd().format(DateTime.now());
}


void anonymousSignInAndLoadPhysicians() async {
  await _auth.signInAnon(); 
  loadPhysicians();
}

void loadPhysicians() async {
  try {
    var items = await _auth.getPhysicianDropdownItems();
    setState(() {
      physicianItems = items;
      if (items.isNotEmpty && physicianUid == null) {
        physicianUid = items.first.value;
      }
    });
  } catch (e) {
    print("Error loading physicians: $e");
  }
}



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthday = DateFormat.yMd().format(picked);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
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
                DropdownButtonFormField<String>(
                  value: gender.isEmpty ? null : gender,
                  hint: const Text('Select Gender'),
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Please select your gender' : null,
                  items: genders.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Birthday',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(text: birthday), 
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context);
                  },
                  readOnly: true,
                  onSaved: (value) => birthday = value ?? '',
                  validator: (value) => value!.isEmpty ? 'Please enter your birthday' : null,
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
                DropdownButtonFormField<String>(
  value: physicianUid, 
  hint: const Text('Select Physician'),
  onChanged: (String? newValue) {
    setState(() {
      physicianUid = newValue ?? '';
      physicianName = physicianItems.firstWhere((item) => item.value == newValue, orElse: () => DropdownMenuItem<String>(value: '', child: Text(''))).child.toString();
    });
  },
  validator: (value) => (value == null || value.isEmpty) ? 'Please select your physician' : null,
  items: physicianItems,
),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState!.save();
                      dynamic result = await _auth.registerPatient(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                        birthday: birthday,
                        gender: gender,
                        physicianUID: physicianUid!
                      );
                      if (result == null) {
                        setState(() => error = 'An error occurred during registration');
                      } else {
                        await FirebaseFirestore.instance.collection('physicians').doc(physicianUid).update({
                          'patients': FieldValue.arrayUnion([result.uid]),
                        });
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
