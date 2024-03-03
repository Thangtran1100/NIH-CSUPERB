import 'package:flutter/material.dart';
import 'package:sdk_demo/services/UnifiedAuthService.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/services/telematics_service.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  final UnifiedAuthService _authService = UnifiedAuthService();
  final TelematicsService _teleAuthService = TelematicsService();
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
        String? accessToken =
            await _authService.getAccessTokenForUser(currentUser.uid);
        if (accessToken != null) {
          String startDate = "2024-01-01";
          String endDate = "2024-02-24";

          String statistics = await _teleAuthService.fetchDailyStatistics(
              startDate, endDate, accessToken);
          setState(() {
            _dailyStatistics = statistics;
          });
        } else {
          setState(() {
            _dailyStatistics = 'Failed to get access token for user.';
          });
        }
      }
    } catch (e) {
      setState(() {
        _dailyStatistics = 'Error fetching statistics: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text(_dailyStatistics),
      ),
    );
  }
}
