import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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

  final _trackingApi = TrackingApi();

  final String instanceId = "49dd2d1c-74c5-4b5f-8713-6410c6b5e1d3";
  final String instanceKey = "74d45fcb-c06f-4204-98e3-56686d60a39b";

  late final String? selectedPhysicianUid;

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

  Future<List<DropdownMenuItem<String>>> getPhysicianDropdownItems() async {
    List<DropdownMenuItem<String>> items = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref('physicians');

    // Only proceed if the user is authenticated
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DatabaseEvent event = await ref.once();
        Map<dynamic, dynamic> physicians =
            event.snapshot.value as Map<dynamic, dynamic>;
        physicians.forEach((key, value) {
          String fullName = '${value['firstName']} ${value['lastName']}';
          items.add(
            DropdownMenuItem(
              value: key,
              child: Text(fullName),
            ),
          );
        });
      } catch (e) {
        print(e.toString());
        // Handle errors or return an empty list
      }
    } else {
      // Handle the case where the user is not authenticated
    }
    return items;
  }

  Future<List<DropdownMenuItem<String>>> getPhysicianDropdownMenu(
      String currentPhysicianId) async {
    List<DropdownMenuItem<String>> items = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref('physicians');

    // Only proceed if the user is authenticated
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DatabaseEvent event = await ref.once();
        Map<dynamic, dynamic> physicians =
            event.snapshot.value as Map<dynamic, dynamic>;
        physicians.forEach((key, value) {
          String firstName = value['firstName'] ?? '';
          String lastName = value['lastName'] ?? '';
          String fullName = '$firstName $lastName'.trim();
          items.add(
            DropdownMenuItem(
              value: key,
              child: Text(fullName),
            ),
          );
        });

        // Find the currently selected physician's UID and set it
        selectedPhysicianUid = currentPhysicianId;
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('No authenticated user found.');
    }

    return items;
  }

  // Register with email, password, and user details for telematics
  Future<AppUser?> registerPatient(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String gender,
      required String birthday,
      required String physicianUID,
      required String physicianName}) async {
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
          'Physician ID': physicianUID,
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

  Future<Map<String, dynamic>?> fetchUserDetails(String uid) async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('patients/$uid');
    try {
      DataSnapshot snapshot = await dbRef.get();
      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      } else {
        print("No user details found for UID $uid.");
      }
    } catch (e) {
      print("Error fetching user details for UID $uid: $e");
    }
    return null;
  }

  Future<String?> getDeviceTokenForUser(String? uid) async {
    if (uid == null) {
      print("UID is null. Cannot retrieve device token.");
      return null;
    }

    DatabaseReference dbRef = FirebaseDatabase.instance.ref('patients/$uid');

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

  Future<void> login(String? deviceToken) async {
    if (deviceToken == null) {
      print('Device token is null. Cannot proceed with login.');
      return; // Early return if deviceToken is null.
    }

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
      // If server returns an OK response, proceed with initialization and tracking
      initializeAndStartTracking(deviceToken);
    } else {
      // If the server did not return a 200 OK response
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

    DatabaseReference dbRef = FirebaseDatabase.instance.ref('patients/$uid');

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

      // Request necessary permissions
      await _trackingApi.showPermissionWizard(
        enableAggressivePermissionsWizard: true,
        enableAggressivePermissionsWizardPage: true,
      );

      // Check if SDK is enabled and enable it if not
      bool isSdkEnabled = await _trackingApi.isSdkEnabled() ?? false;
      if (!isSdkEnabled) {
        await _trackingApi.setEnableSdk(enable: true);
        print("SDK enabled");
      }

      bool trackingStatus = await _trackingApi.isTracking() ?? false;
      if (!trackingStatus) {
        await _trackingApi.startManualTracking();
        print("Tracking enabled");
      } else {
        print(trackingStatus);
        print("Tracking already enabled");
      }

      print("SDK enabled");
    } catch (e) {
      print("Error initializing and starting tracking: $e");
    }
  }

  Future<Map<String, dynamic>?> fetchTrips(String authToken) async {
    final startDate = DateTime(2024, 1, 1).toUtc().toIso8601String();
    final endDate = DateTime.now().toUtc().toIso8601String();

    var headers = {
      'accept': 'application/json',
      'content-type': 'application/json',
      'authorization': 'Bearer $authToken',
    };

    var body = jsonEncode({
      "StartDate": startDate,
      "EndDate": endDate,
      "SortBy": "StartDateUtc",
      "IncludeRelated": true,
      "Paging": {"Page": 1, "Count": 10, "IncludePagingInfo": true}
    });

    var response = await http.post(
      Uri.parse("https://api.telematicssdk.com/trips/get/v1/short/"),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // Decode the JSON response body to a Dart object
      final data = jsonDecode(response.body);
      print('Data fetched successfully');
      return data; // Return the decoded body
    } else {
      // Handle error
      print('Failed to fetch data');
      return null;
    }
  }

  // Function to check the user's role
  Future<String> checkUserRole(String uid) async {
    // Check if UID exists under 'physicians' node
    final physicianRef = FirebaseDatabase.instance.ref('physicians/$uid');
    final physicianSnapshot = await physicianRef.get();

    if (physicianSnapshot.exists) {
      return 'Physician';
    }

    // Check if UID exists under 'patients' node
    final patientRef = FirebaseDatabase.instance.ref('patients/$uid');
    final patientSnapshot = await patientRef.get();

    if (patientSnapshot.exists) {
      return 'Patient';
    }

    // User is neither a physician nor a patient, or doesn't exist
    return 'Unknown';
  }
}
