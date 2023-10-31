import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import '../models/driving_data.dart';

class TrackingService {
  List<DrivingData> drivingDataList = [];
  
  StreamSubscription<Position>? positionStream;
  StreamSubscription<SensorEvent>? accelerometerSubscription;

  startTracking() {
    // Start tracking location
    positionStream = Geolocator.getPositionStream().listen((Position position) {
        SensorManager().sensorUpdates(
          sensorId: Sensors.ACCELEROMETER,
          interval: Sensors.SENSOR_DELAY_FASTEST,
        ).then((stream) {
          accelerometerSubscription = stream.listen((SensorEvent event) {
            drivingDataList.add(DrivingData(
              timestamp: DateTime.now(),
              speed: position.speed,
              acceleration: event.data[0], // Taking just one axis as an example
            ));
          });
        });
      
    });
  }

  stopTracking() {
    positionStream?.cancel();
    accelerometerSubscription?.cancel();
  }

  // Any other functions or logic related to tracking can be added here.
}
