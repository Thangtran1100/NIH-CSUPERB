import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/services/telematics_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:telematics_sdk/telematics_sdk.dart';

class UnifiedAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TelematicsService _telematicsService = TelematicsService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final TrackingApi _trackingApi = TrackingApi();

  final String instanceId = "213cc2b3-59c3-4fbf-b66a-dab7f53406d9";
  final String instanceKey = "0ec87b0e-5eb2-4e79-a439-3e16aa36104c";

  // Converts Firebase User to custom AppUser
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign-in anonymous
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign-out
  Future signedOut() async {
    try {
      print('User Signed Out');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email, password, and user details for telematics
  Future<AppUser?> registerPatient({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gender,
    required String birthday,
    required String physicianName
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
        email: email,
      );

      // Store telematics tokens and username in Firebase database linked to the user's UID
      if (firebaseUser != null) {
        await _database.ref('patients/${firebaseUser.uid}').set({
          'deviceToken': tokenResponse.deviceToken,
          'accessToken': tokenResponse.accessToken,
          'refreshToken': tokenResponse.refreshToken,
          'firstName': firstName,
          'lastName': lastName,
          'gender': gender,
          'birthday': birthday,
          'email': email,
          'Physician Name': physicianName
        });
      }

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<AppUser?> registerPhysician({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String organizationName,
    required String npi,
    required String phone,
  }) async {
    try {
      // Create user with email and password in Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;

      // If the user was successfully created, proceed to store their details
      if (firebaseUser != null) {
        // Prepare physician-specific details
        final physicianDetails = {
          'firstName': firstName,
          'lastName': lastName,
          'organizationName': organizationName,
          'npi': npi,
          'phone': phone,
          'email': email,
        };

        // Store physician details in Firebase Database under a 'physicians' node
        await _database
            .ref('physicians/${firebaseUser.uid}')
            .set(physicianDetails);
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

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  AppUser? getCurrentAppUser() {
    return _userFromFirebaseUser(_auth.currentUser);
  }

  Future<bool> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String gender,
    required String birthday,
    required String physicianName,
  }) async {
    try {
      // Here you would typically make a call to your backend.
      // This is a placeholder for whatever service you use, for example, Firebase:
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'birthday': birthday,
        'physicianName': physicianName,
      });

      // If the call succeeds, return true
      return true;
    } catch (e) {
      // Handle any errors here
      print(e.toString());
      return false;
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
          //login(deviceToken);
          initializeAndStartTracking(deviceToken!);
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

  Future<void> login(String? deviceToken) async {
    var url = Uri.parse('https://user.telematicssdk.com/v1/Auth/Login');

    var headers = {
      'accept': 'application/json',
      'InstanceId': instanceId,
      'content-type': 'application/json',
    };

    var body = jsonEncode({
      'LoginFields': {"Devicetoken": deviceToken},
      'Password': instanceKey
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print('Login Successful');
    } else {
      // If the server did not return a 200 OK response,
      print(
          'Failed to login, status code: ${response.statusCode}, body: ${response.body}');
      throw Exception(
          'Failed to load data, status code: ${response.statusCode}');
    }
  }

  Future<String?> getAccessTokenForUser(String? uid) async {
    if (uid == null) {
      print("UID is null. Cannot retrieve access token.");
      return null;
    }

    DatabaseReference dbRef = FirebaseDatabase.instance.ref('userTokens/$uid');

    try {
      DataSnapshot snapshot = await dbRef.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>?;
        if (data != null && data.containsKey('accessToken')) {
          final String? accessToken = data['accessToken'];
          print("Access token for UID $uid is: $accessToken");
          return accessToken;
        } else {
          print("Access token not found for UID $uid.");
        }
      } else {
        print("Snapshot does not exist for UID $uid.");
      }
    } catch (e) {
      print(
          "An error occurred while trying to fetch access token for UID $uid: $e");
    }

    return null;
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

  // Method to change the current user's email
  Future<void> changeEmail(String newEmail) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updateEmail(newEmail);
        print("Email updated successfully to $newEmail");
      } catch (e) {
        print("Failed to update email: $e");
        // Handle the error appropriately
      }
    } else {
      print("No user is currently signed in.");
    }
  }

  // Method to change the current user's password
  Future<void> changePassword(String newPassword) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        print("Password updated successfully.");
      } catch (e) {
        print("Failed to update password: $e");
        // Handle the error appropriately
      }
    } else {
      print("No user is currently signed in.");
    }
  }

  // Method to initialize and start tracking with the given device token
  Future<void> initializeAndStartTracking(String deviceToken) async {
    try {
      // Initialize the SDK with the device token
      await _trackingApi.setDeviceID(deviceId: deviceToken);

      // Show the permission wizard and request necessary permissions
      _trackingApi.showPermissionWizard(
        enableAggressivePermissionsWizard: true,
        enableAggressivePermissionsWizardPage: true,
      );

      // Listener for permission wizard result
      final permissionWizardResult =
          await _trackingApi.onPermissionWizardClose.first;
      if (permissionWizardResult == PermissionWizardResult.allGranted) {
        // Check if SDK is enabled and enable it if not
        final isSdkEnabled = await _trackingApi.isSdkEnabled() ?? false;
        if (!isSdkEnabled) {
          await _trackingApi.setEnableSdk(enable: true);
        }

        // Start tracking
        final isTracking = await _trackingApi.isTracking() ?? false;
        if (!isTracking) {
          await _trackingApi.startTracking();
        }

        print("SDK Enabled and Tracking Started");
      } else {
        print(
            "Permissions not fully granted. SDK not enabled and tracking not started.");
      }
    } catch (e) {
      print("Error initializing and starting tracking: $e");
    }
  }

  // Method to fetch daily statistics from the Telematics API
  Future<String> fetchDailyStatistics(
      String startDate, String endDate, String authToken) async {
    var client = http.Client();
    String statistics = '';
    try {
      var url = Uri.parse(
              'https://api.telematicssdk.com/indicators/v2/Statistics/daily')
          .replace(queryParameters: {
        'StartDate': startDate,
        'EndDate': endDate,
      });

      final response = await client.get(
        url,
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        statistics = response.body;
      } else {
        print(
            'Failed to fetch daily statistics, status code: ${response.statusCode}, response: ${response.body}');
      }
    } catch (e) {
      print('Error fetching daily statistics: $e');
    } finally {
      client.close();
    }
    return statistics;
  }
}
