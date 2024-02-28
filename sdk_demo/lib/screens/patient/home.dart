import 'package:flutter/material.dart';
import 'package:sdk_demo/screens/patient/profile.dart';
import 'package:sdk_demo/screens/patient/settings.dart';
import 'package:sdk_demo/screens/patient/updateCredentials.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'Drives.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UnifiedAuthService _auth = UnifiedAuthService();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Text('Home Page'), 
    DrivesPage(),            
    PatientProfileEditPage(),
    UpdateCredentials(),
    SettingsPage()               
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Demo App'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Logout'),
            onPressed: () async {
              await _auth.signedOut();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[400], 
              onPrimary: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue[400],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta),
            label: 'Drives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Update Credentials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
