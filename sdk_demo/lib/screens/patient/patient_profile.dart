import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userDetails;

  const ProfilePage({Key? key, required this.userDetails}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UnifiedAuthService _auth = UnifiedAuthService();

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  String? _selectedGender;
  String? _selectedPhysicianUid;
  List<DropdownMenuItem<String>> _physicianItems = [];

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthdayController;
  late TextEditingController _genderController;
  late TextEditingController _emailController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.userDetails['gender'];
    _firstNameController = TextEditingController(text: widget.userDetails['firstName']);
    _lastNameController = TextEditingController(text: widget.userDetails['lastName']);
    _birthdayController = TextEditingController(text: widget.userDetails['birthday']);
    _genderController = TextEditingController(text: widget.userDetails['gender']);
    _emailController = TextEditingController(text: widget.userDetails['email']);
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _selectedPhysicianUid = widget.userDetails['Physician ID'];
    _loadPhysicians();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthdayController.text.isNotEmpty
          ? DateTime.tryParse(_birthdayController.text) ?? DateTime.now()
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> updateUserInformationRealtimeDatabase() async {
    String uid = _auth.getCurrentUser()?.uid ?? '';
    if (uid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: User is not logged in")),
      );
      return;
    }

    Map<String, dynamic> updatedUserData = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'birthday': _birthdayController.text,
      'gender': _selectedGender, 
      'email': _emailController.text.trim(),
      'Physician ID': _selectedPhysicianUid,
    };

    await FirebaseDatabase.instance
        .ref('patients/$uid')
        .update(updatedUserData)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User information updated successfully")),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update user information")),
      );
    });
  }

  Future<void> updateUserPassword() async {
  if (_newPasswordController.text.trim().isEmpty && _confirmPasswordController.text.trim().isEmpty) {
    return;
  }

  if (_newPasswordController.text.trim() == _confirmPasswordController.text.trim()) {
    try {
      await _auth
          .getCurrentUser()
          ?.updatePassword(_newPasswordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update password: $error")),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Passwords do not match")),
    );
  }
}


  void userSignInAndLoadPhysicians() async {
  _auth.getCurrentAppUser(); 
}

  void _loadPhysicians() async {
    try {
      var items = await _auth.getPhysicianDropdownItems();
      setState(() {
        _physicianItems = items;
        if (_selectedPhysicianUid == null || !items.any((item) => item.value == _selectedPhysicianUid)) {
          _selectedPhysicianUid = items.first.value;
        }
      });
    } catch (e) {
      print("Error loading physicians: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _birthdayController,
              decoration: const InputDecoration(
                labelText: 'Birthday',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true, 
              onTap: () => _selectBirthday(context),
            ),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(labelText: 'Gender'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              items:
                  _genderOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedPhysicianUid,
              decoration: const InputDecoration(labelText: 'Physician'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPhysicianUid = newValue;
                });
              },
              items: _physicianItems,
              validator: (value) => (value == null || value.isEmpty) ? 'Please select your physician' : null,
            ),
            TextFormField(
              controller: _newPasswordController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true, 
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateUserInformationRealtimeDatabase();
                updateUserPassword();
              },
              child: const Text('Update Information'),
            ),
          ],
        ),
      ),
    );
  }
}
