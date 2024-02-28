import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/physician_authenticate.dart';
import 'package:sdk_demo/screens/authenticate/patient_authenticate.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToPhysicianAuthenticate() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PhysicianAuthenticate()),
      );
    }

    void navigateToPatientAuthenticate() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PatientAuthenticate()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: navigateToPhysicianAuthenticate,
              child: const Text('Physician'),
            ),
            const SizedBox(height: 20), // Add space between the buttons
            ElevatedButton(
              onPressed: navigateToPatientAuthenticate,
              child: const Text('Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
