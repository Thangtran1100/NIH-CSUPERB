import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenResponse {
  final String deviceToken;
  final String accessToken;
  final String refreshToken;

  TokenResponse({this.deviceToken = '', this.accessToken = '', this.refreshToken = ''});
}

class TelematicsService {
  static Future<TokenResponse> createDeviceToken() async {
    String instanceId = '602b018a-1a3b-4026-8698-1d5746902ae6'; //This can be change 
    String instanceKey = '8adc6dd8-e8c9-4576-b731-37ca92d5669f'; //This can be change
    var client = http.Client();
    var url =
        Uri.parse('https://user.telematicssdk.com/v1/Registration/create');

    var headers = {
      'accept': 'application/json',
      'InstanceId': instanceId,
      'InstanceKey': instanceKey,
      'content-type': 'application/json'
    };

    var body = json.encode({
      "UserFields": {"ClientId": "string"}
    });

    try {
      var response = await client.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Return the response body as a Map
        var responseData = json.decode(response.body);

        return TokenResponse(
          deviceToken: responseData['Result']['DeviceToken'],
          accessToken: responseData['Result']['AccessToken']['Token'],
          refreshToken: responseData['Result']['RefreshToken'],
        );
      } else {
        // Throw an exception or return a default value if the response is not successful
        throw Exception('Failed to load tokens: ${response.statusCode}');
      }
    } catch (e) {
      // Throw the exception to be handled by the caller
      throw Exception('Exception occurred: $e');
    } finally {
      client.close();
    }
  }
}
