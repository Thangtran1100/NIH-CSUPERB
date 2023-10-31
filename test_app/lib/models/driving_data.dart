class DrivingData {
  final DateTime timestamp;
  final double speed; // in m/s
  final double acceleration; // from accelerometer

  DrivingData({
    required this.timestamp,
    required this.speed,
    required this.acceleration,
  });
}
