import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sdk_demo/screens/patient/patient_settings.dart';

class PhysicianHome extends StatefulWidget {
  const PhysicianHome({super.key});

  @override
  _PhysicianHomeState createState() => _PhysicianHomeState();
}

class _PhysicianHomeState extends State<PhysicianHome> {
  List<Map<dynamic, dynamic>> _patientsList = [];
  List<Map<dynamic, dynamic>> _filteredPatientsList = [];

  TextEditingController _filterController = TextEditingController();
  TextEditingController _physicianFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPatients();
    _filterController.addListener(_filterPatientsList);
    _physicianFilterController.addListener(_filterPatientsList);
  }

  Future<void> _fetchPatients() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('patients');
  DatabaseEvent event = await ref.once();

  if (event.snapshot.exists) {
    List<Map<dynamic, dynamic>> patients = [];
    event.snapshot.children.forEach((DataSnapshot snapshot) {
      var patient = Map<dynamic, dynamic>.from(snapshot.value as Map);
      patient['key'] = snapshot.key;
      patients.add(patient);
    });

    patients.sort((a, b) {
      String emailA = a['email']?.toLowerCase() ?? ''; 
      String emailB = b['email']?.toLowerCase() ?? '';
      return emailA.compareTo(emailB);
    });

    setState(() {
      _patientsList = patients;
      _filteredPatientsList = List.from(patients); 
    });
  }
}


  void _filterPatientsList() {
    String emailFilter = _filterController.text.toLowerCase();
    String physicianFilter = _physicianFilterController.text.toLowerCase();

    List<Map<dynamic, dynamic>> filteredList = _patientsList.where((patient) {
      String email = patient['email']?.toLowerCase() ?? '';
      String physicianName = patient['Physician Name']?.toLowerCase() ?? '';
      return email.contains(emailFilter) &&
          physicianName.contains(physicianFilter);
    }).toList();

    setState(() {
      _filteredPatientsList = filteredList;
    });
  }

  Widget _buildPatientsList() {
    return ListView.builder(
      itemCount: _filteredPatientsList.length,
      itemBuilder: (context, index) {
        var patient = _filteredPatientsList[index];
        String fullName =
            '${patient['firstName'] ?? 'No name'} ${patient['lastName'] ?? ''}'
                .trim();

        Widget details = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Email: ${patient['email'] ?? 'No email'}'),
              Text(
                  'Physician Name: ${patient['Physician Name'] ?? 'No physician name'}'),
              Text('Birthday: ${patient['birthday'] ?? 'No birthday'}'),
              Text('Gender: ${patient['gender'] ?? 'No gender'}'),
            ],
          ),
        );

        return ExpansionTile(
          title: Text(fullName, style: TextStyle(fontWeight: FontWeight.bold)),
          children: [details],
          leading: Icon(Icons.person),
        );
      },
    );
  }

  @override
  void dispose() {
    _filterController.dispose();
    _physicianFilterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _filterController,
              decoration: InputDecoration(
                labelText: 'Filter by email',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _physicianFilterController,
              decoration: InputDecoration(
                labelText: 'Filter by physician name',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(child: _buildPatientsList()),
        ],
      ),
    );
  }
}
