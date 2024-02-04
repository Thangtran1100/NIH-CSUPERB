import 'package:flutter/material.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/screens/authenticate/authenticate.dart';
import 'package:sdk_demo/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
