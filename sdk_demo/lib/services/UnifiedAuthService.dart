import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdk_demo/models/user.dart';
import 'package:sdk_demo/services/telematics_service.dart';
import 'package:firebase_database/firebase_database.dart';

class UnifiedAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TelematicsService _telematicsService = TelematicsService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

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
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;

      // Register user in telematics system
      TokenResponse tokenResponse = await _telematicsService.registerUser(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        clientId: clientId,
      );

      // Store telematics tokens in Firebase database linked to the user's UID
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

  // Add signInWithEmailAndPassword, signInAnon, and signOut methods from AuthService here
  // Modify them as necessary to integrate telematics token retrieval and management
}
