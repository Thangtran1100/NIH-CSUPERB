import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sdk_demo/screens/patient/patient_settings.dart';
import 'package:sdk_demo/screens/patient/patient_trips.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Timer? _inactivityTimer;
  bool _isTripOngoing = false;
  String _speedInfo = "Waiting for trip to start...";
  final double notMovingSpeedThreshold = 0.5; // meters per second
  final int inactivityTimeout = 600; // seconds

  final List<String> titles = ['Home Page', 'Settings'];

  @override
  void initState() {
    super.initState();
    startListeningLocation();
  }

  void startListeningLocation() {
  Geolocator.getPositionStream().listen((Position position) {
    double speedInMetersPerSecond = max(position.speed, 0); // Ensure speed is not negative

    // Convert speed from m/s to mph
    double speedInMph = speedInMetersPerSecond * 2.23694;

    setState(() {
      if (speedInMetersPerSecond > notMovingSpeedThreshold) {
        if (!_isTripOngoing) {
          // Trip starts
          _isTripOngoing = true;
          _speedInfo = "Trip started. Speed: ${speedInMph.toStringAsFixed(2)} mph";
          _inactivityTimer?.cancel(); // Cancel any existing timer
          print("Trip started");
        } else {
          _speedInfo = "Speed: ${speedInMph.toStringAsFixed(2)} mph";
        }
      } else if (_isTripOngoing) {
        // Device is stationary, start or reset inactivity timer
        _inactivityTimer?.cancel();
        _inactivityTimer = Timer(Duration(seconds: inactivityTimeout), () {
          // Consider the trip ended after being stationary for a certain period
          _isTripOngoing = false;
          _speedInfo = "Trip ended. Device is stationary.";
          print("Trip ended");

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _showEndOfTripDialog(context);
            }
          });
        });
      }
    });
  });
}


  @override
  void dispose() {
    _inactivityTimer?.cancel(); // Clean up the timer
    super.dispose();
  }

  void _showEndOfTripDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Trip Completed'),
          content: const Text('Were you the driver for this trip?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Handle the user's confirmation that they were the driver
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Handle the user's response that they were not the driver
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Center(child: Text(_speedInfo)),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
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
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TripsPage()),
          );
        },
        child: Icon(Icons.directions_car),
      ),
    );
  }
}
