// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../services/tracking_service.dart'; // Adjust the import path accordingly
import '../logic/driving_score_calculator.dart'; // Adjust the import path accordingly
import 'safety_score.dart';
import 'title_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TrackingService _trackingService = TrackingService();
  final DrivingScoreCalculator _scoreCalculator = DrivingScoreCalculator();

  bool _isTracking = false;
  int _score = 100; // Default score

  _toggleTracking() {
    if (_isTracking) {
      _trackingService.stopTracking();
      setState(() {
        _score =
            _scoreCalculator.computeScore(_trackingService.drivingDataList);
        _isTracking = false;
      });
    } else {
      _trackingService.startTracking();
      setState(() {
        _isTracking = true;
      });
    }
  }

  _navigateToSafetyScore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SafetyScorePage(score: _score),
      ),
    );
  }

  _navigateToTitleScreen() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TitleScreen(),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driving Score App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Driving Score: $_score',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _toggleTracking,
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
            const SizedBox(height: 20), // Provides spacing between the buttons
            ElevatedButton(
              onPressed: _navigateToSafetyScore,
              child: const Text('View Overall Safety Score'),
            ),
            const SizedBox(height: 20), // Provides spacing between the buttons
            ElevatedButton(
              onPressed: _navigateToTitleScreen,
              child: const Text('Check SDK Status'),
            )
          ],
        ),
      ),
    );
  }
}
