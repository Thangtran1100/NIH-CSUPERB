import 'package:flutter/material.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/screens/authenticate/roleSelectionScreen.dart';
import 'package:sdk_demo/screens/patient/patient_home.dart';
import 'package:provider/provider.dart';
import 'package:sdk_demo/screens/welcome.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if (user == null) {
      return const Welcome();
    } else {
      return const Home();
    }
  }
}
