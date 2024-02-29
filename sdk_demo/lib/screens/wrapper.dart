import 'package:flutter/material.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/screens/authenticate/roleSelectionScreen.dart';
import 'package:sdk_demo/screens/patient/patient_home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if (user == null) {
      return const RoleSelectionScreen();
    } else {
      return const Home();
    }
  }
}
