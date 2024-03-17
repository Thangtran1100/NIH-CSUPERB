import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'package:sdk_demo/models/user.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  final UnifiedAuthService _authService = UnifiedAuthService();
  String _dailyStatistics = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchAndDisplayStatistics();
  }

  Future<void> _fetchAndDisplayStatistics() async {
  try {
    AppUser? currentUser = _authService.getCurrentAppUser();
    if (currentUser != null) {
      String? accessToken = await _authService.getAccessTokenForUser(currentUser.uid);
      if (accessToken != null) {
        var statistics = await _authService.fetchTrips(accessToken);
        // Assuming you want to display the statistics as a JSON string:
        if (statistics != null) {
          String statStrings = jsonEncode(statistics);
          setState(() {
            _dailyStatistics = statStrings;
          });
        } else {
          setState(() {
            _dailyStatistics = 'Failed to fetch data or no data returned.';
          });
        }
      } else {
        setState(() {
          _dailyStatistics = 'Failed to get access token for user.';
        });
      }
    }
  } catch (e) {
    print(e);
    setState(() {
      _dailyStatistics = 'Error fetching statistics: $e';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips Page'),
      ),
      body: Center(
        child: Text(_dailyStatistics),
      ),
    );
  }
}
