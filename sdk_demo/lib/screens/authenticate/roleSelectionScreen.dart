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

    const _sizedBoxSpace = SizedBox(height: 50);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          title: const Text('Select Your Role'),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                Icon(Icons.medical_information, size: 100),
                SizedBox(
                  width: 200.0,
                  height: 150.0,
                  child: ElevatedButton(
                    onPressed: navigateToPhysicianAuthenticate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 4, 27, 63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                    child: const Text(
                      'PHYSICIAN PORTAL',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                _sizedBoxSpace,
                Icon(Icons.person, size: 100),
                SizedBox(
                  width: 200.0,
                  height: 150.0,
                  child: ElevatedButton(
                    onPressed: navigateToPatientAuthenticate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 103, 139, 183),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                    child: const Text(
                      'PATIENT PORTAL',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
