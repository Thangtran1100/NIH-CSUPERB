import 'package:flutter/material.dart';

class SafetyScorePage extends StatelessWidget {
  final int score;

  const SafetyScorePage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overall Safety Score')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your Safety Score Is:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '$score', 
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
