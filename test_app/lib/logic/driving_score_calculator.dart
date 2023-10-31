import '../models/driving_data.dart';

class DrivingScoreCalculator {
  int computeScore(List<DrivingData> data) {
    int score = 100;

    for (int i = 0; i < data.length; i++) {
      // Deduct for speeding
      if (data[i].speed > 27.78) { // 100 km/h in m/s
        score -= 2;
      }

      // Deduct for hard brakes (simple example, might require tuning)
      if (i > 0 && data[i].acceleration - data[i-1].acceleration > 5.0) {
        score -= 5;
      }

      // Deduct for sharp turns (just a basic idea, would need more complex logic)
      if (data[i].acceleration > 5.0) {
        score -= 3;
      }

      // Ensure score doesn't drop below 0
      if (score < 0) score = 0;
    }

    return score;
  }
  
  // Any other analytics or algorithms can be added here.
}
