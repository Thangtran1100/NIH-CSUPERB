import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';

class PatientProfileEditPage extends StatefulWidget {
  @override
  _PatientProfileEditPageState createState() => _PatientProfileEditPageState();
}

class _PatientProfileEditPageState extends State<PatientProfileEditPage> {
  final UnifiedAuthService _auth = UnifiedAuthService();
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String gender = '';
  DateTime birthday = DateTime.parse('');
  String physicianName = 'loum';

  List<String> genders = ['Male', 'Female', 'Other'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthday,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthday) {
      setState(() {
        birthday = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: firstName,
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) => firstName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter your first name' : null,
              ),
              TextFormField(
                initialValue: lastName,
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => lastName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter your last name' : null,
              ),
              DropdownButtonFormField<String>(
                value: gender,
                decoration: InputDecoration(labelText: 'Gender'),
                onChanged: (String? newValue) {
                  setState(() {
                    gender = newValue!;
                  });
                },
                onSaved: (value) => gender = value!,
                items: genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Birthday',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                controller: TextEditingController(text: DateFormat.yMd().format(birthday)),
                onTap: () => _selectDate(context),
                onSaved: (value) {
                  if (value != null) {
                    birthday = DateFormat.yMd().parse(value);
                  }
                },
                validator: (value) => value!.isEmpty ? 'Please enter your birthday' : null,
              ),
              TextFormField(
                initialValue: physicianName,
                decoration: InputDecoration(labelText: 'Physician Name'),
                onSaved: (value) => physicianName = value!,
                validator: (value) => value!.isEmpty ? 'Please enter your physician name' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save Changes'),
                onPressed: _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
