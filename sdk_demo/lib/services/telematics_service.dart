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
final String instanceId = "49dd2d1c-74c5-4b5f-8713-6410c6b5e1d3";
    final String instanceKey = "74d45fcb-c06f-4204-98e3-56686d60a39b";

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
