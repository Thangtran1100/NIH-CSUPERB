import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenResponse {
  final String deviceToken;
  final String accessToken;
  final String refreshToken;

  TokenResponse(
      {this.deviceToken = '', this.accessToken = '', this.refreshToken = ''});
}

class TelematicsService {
final String instanceId = "213cc2b3-59c3-4fbf-b66a-dab7f53406d9";
    final String instanceKey = "0ec87b0e-5eb2-4e79-a439-3e16aa36104c";

  Future<TokenResponse> registerUser({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    
    const String url = "https://user.telematicssdk.com/v1/Registration/create";

    var body = jsonEncode({
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
    });
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "accept": "application/json",
          "InstanceId": instanceId,
          "InstanceKey": instanceKey,
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("Registration successful");

        var responseData = json.decode(response.body);

        print(responseData['Result']['DeviceToken']);

        return TokenResponse(
          deviceToken: responseData['Result']['DeviceToken'],
          accessToken: responseData['Result']['AccessToken']['Token'],
          refreshToken: responseData['Result']['RefreshToken'],
        );
      } else {
        throw Exception('Failed to register user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception occurred during registration: $e');
    }
  }

  Future<Map<String, dynamic>> loginWithDeviceToken(String deviceToken) async {
    var body = jsonEncode({
      "LoginFields": "{\"DeviceToken\":\"$deviceToken\"}",
      "Password": instanceKey,
    });

    var response = await http.post(
      Uri.parse('https://user.telematicssdk.com/v1/Auth/Login'),
      headers: {
        "accept": "application/json",
        "InstanceId": instanceId,
        "content-type": "application/json",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return {
        'accessToken': data['accessToken'],
        'refreshToken': data['refreshToken'],
      };
    } else {
      print("Login failed: ${response.body}");
      throw Exception('Failed to login with device token: ${response.statusCode}');
    }
  }
}
