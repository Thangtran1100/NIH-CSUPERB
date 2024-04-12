import 'dart:async';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sdk_demo/screens/patient/patient_settings.dart';
import 'package:sdk_demo/screens/patient/patient_trips.dart';
import 'package:sdk_demo/services/notification_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with WidgetsBindingObserver{
  int _currentIndex = 0;
  Timer? _inactivityTimer;
  bool _isTripOngoing = false;
  String _speedInfo = "Waiting for trip to start...";
  final double notMovingSpeedThreshold = 2.2352; // meters per second
  final int inactivityTimeout = 60; // seconds

  final List<String> titles = ['Home Page', 'Settings'];

  final NotificationService notificationService = NotificationService();

  bool _isAppInForeground = true;


  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationService.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationService.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationService.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationService.onDismissActionReceivedMethod);
    WidgetsBinding.instance.addObserver(this);
    startListeningLocation();
  }

  @override
void didChangeAppLifecycleState(AppLifecycleState state) {
  super.didChangeAppLifecycleState(state);
  _isAppInForeground = state == AppLifecycleState.resumed;
}



  void startListeningLocation() {
  Geolocator.getPositionStream().listen((Position position) {
    double speedInMetersPerSecond = max(position.speed, 0); // Ensure speed is not negative

    // Convert speed from m/s to mph
    double speedInMph = speedInMetersPerSecond * 2.23694;

    bool isCurrentlyMoving = speedInMph > notMovingSpeedThreshold;

    setState(() {
      // Only update trip state if there is a change
      if (isCurrentlyMoving != _isTripOngoing) {
        if (isCurrentlyMoving) {
          // Movement detected
          _isTripOngoing = true;
          _speedInfo = "Trip started. Speed: ${speedInMph.toStringAsFixed(2)} mph";
          print("Trip started");
          _inactivityTimer?.cancel();
        } else {
          // End of trip detected, start inactivity timer
          _inactivityTimer?.cancel();
          _inactivityTimer = Timer(Duration(seconds: inactivityTimeout), () {
            _isTripOngoing = false;
            _speedInfo = "Trip ended. Device is stationary.";
            print("Trip ended");

            if (_isAppInForeground) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) {
      _showEndOfTripDialog(context);
    }
  });
} else {
  NotificationService.showEndTripNotification(
    title: 'Trip Completed',
    body: 'Were you the driver for this trip?'
  );
}

          });
        }
      } else if (_isTripOngoing) {
        // Update speed info without changing trip state
        _speedInfo = "Speed: ${speedInMph.toStringAsFixed(2)} mph";
      }
    }); 
  });
}


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
                Navigator.of(context).pop(); 
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
