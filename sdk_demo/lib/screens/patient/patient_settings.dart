import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/authenticate/roleSelectionScreen.dart';
import 'package:sdk_demo/screens/patient/patient_profile.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UnifiedAuthService _auth = UnifiedAuthService();

  late Future<Map<String, dynamic>?> userDetailsFuture;

  @override
  void initState() {
    super.initState();
    userDetailsFuture =
        _auth.fetchUserDetails(_auth.getCurrentUser()?.uid ?? '');
  }

  void navigateToProfilePage() async {
    String uid = _auth.getCurrentUser()?.uid ?? '';
    Map<String, dynamic>? userDetails = await _auth.fetchUserDetails(uid);
    
    if (!mounted) return;

    if (userDetails != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(userDetails: userDetails),
        ),
      );
    } else {
      print("Failed to fetch user details.");
    }
  }

  void signOut() async {
    await _auth.signedOut();
    if (!mounted) return;

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RoleSelectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 50),
                const ListTile(
                  title: Text(
                    'Account',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 2, 80, 168)),
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: const Icon(Icons.person_2_outlined),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    setState(
                      () {
                        navigateToProfilePage();
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                const ListTile(
                  title: Text(
                    'Information',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 80, 168),
                      fontSize: 16,
                    ),
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: const Text('Tutorial'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About App'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Privacy Statement'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.data_exploration_sharp),
                  title: const Text('Request My Data'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: signOut,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: const Center(
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
