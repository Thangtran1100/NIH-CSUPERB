import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/patient_authenticate.dart';
import 'package:sdk_demo/screens/authenticate/patient_sign_in.dart';
import 'package:sdk_demo/screens/welcome.dart';
import 'package:sdk_demo/utilities/colors.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Welcome(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/physician-icon.png',
                height: 100,
              ),
              const SizedBox(
                height: 2.0,
              ),
              SizedBox(
                height: 150,
                width: 300,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: kDarkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  child: const Text(
                    'Physician Portal',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/consumer-icon.png',
                height: 80,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 150,
                width: 300,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PatientAuthenticate(),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: kLightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  child: const Text(
                    'Consumer Portal',
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
      ),
    );
  }
}
