import 'package:flutter/material.dart';
import 'package:senior_appv1/pages/settings_page.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  _TrackingPage createState() => _TrackingPage();
}

class _TrackingPage extends State<TrackingPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1){
      //Navigator.push(context, route)
      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline_rounded,
              size: 35,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color.fromARGB(
                      255, 103, 139, 183), // Specify the desired color
                  BlendMode.srcIn, // Use BlendMode.srcIn to apply the color
                ),
                child: Image.asset(
                  'assets/images/car-road-logo.png',
                  height: 250,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 350,
            left: 140,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Tracking is',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 450,
            left: 170,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '-OFF-',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}