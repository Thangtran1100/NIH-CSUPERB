import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcrypt/bcrypt.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/services/telematics_service.dart';
import 'package:firebase_database/firebase_database.dart';

class UnifiedAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TelematicsService _telematicsService = TelematicsService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final String instanceId = "602b018a-1a3b-4026-8698-1d5746902ae6";
  final String instanceKey = "8adc6dd8-e8c9-4576-b731-37ca92d5669f";

  // Converts Firebase User to custom AppUser
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Register with email, password, and user details for telematics
  Future<AppUser?> registerUser({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String phone,
  required String clientId,
}) async {
  try {
    // Firebase Authentication to create user
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? firebaseUser = result.user;

    // Register user in telematics system
    TokenResponse tokenResponse = await _telematicsService.registerUser(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      clientId: clientId,
    );

    // Store telematics tokens and username in Firebase database linked to the user's UID
    if (firebaseUser != null) {
      await _database.ref('userTokens/${firebaseUser.uid}').set({
        'deviceToken': tokenResponse.deviceToken,
        'accessToken': tokenResponse.accessToken,
        'refreshToken': tokenResponse.refreshToken,
      });
    }

    return _userFromFirebaseUser(firebaseUser);
  } catch (e) {
    print(e.toString());
    return null;
  }
}


  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<String?> getDeviceTokenForUser(String? uid) async {
    if (uid == null) {
      print("UID is null. Cannot retrieve device token.");
      return null;
    }

    DatabaseReference dbRef = FirebaseDatabase.instance.ref('userTokens/$uid');

    try {
      DataSnapshot snapshot = await dbRef.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>?;
        if (data != null && data.containsKey('deviceToken')) {
          final String? deviceToken = data['deviceToken'];
          print("Device token for UID $uid is: $deviceToken");
          login(deviceToken);
          return deviceToken;
        } else {
          print("Device token not found for UID $uid.");
        }
      } else {
        print("Snapshot does not exist for UID $uid.");
      }
    } catch (e) {
      print(
          "An error occurred while trying to fetch device token for UID $uid: $e");
    }

    return null;
  }

  Future<void> login(String? userId) async {
    var url = Uri.parse('https://user.telematicssdk.com/v1/Auth/Login');

    var headers = {
      'accept': 'application/json',
      'InstanceId': '602b018a-1a3b-4026-8698-1d5746902ae6',
      'content-type': 'application/json',
    };

    var body = jsonEncode({
      'LoginFields': {"Devicetoken": userId},
      'Password': '8adc6dd8-e8c9-4576-b731-37ca92d5669f'
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print('Response data: ${response.body}');
    } else {
      // If the server did not return a 200 OK response,
      print(
          'Failed to login, status code: ${response.statusCode}, body: ${response.body}');
      throw Exception(
          'Failed to load data, status code: ${response.statusCode}');
    }

    print("Login here");
  }

  Future<void> resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print("Password reset email sent to $email");
  } catch (e) {
    print("Failed to send password reset email: $e");
    // Handle the error appropriately
  }
}
}
