import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseAuthHelper {
  static Future<String?> getAccessToken() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/credentials/service_account.json',
      );
      final jsonData = json.decode(jsonString);

      final credentials = auth.ServiceAccountCredentials.fromJson(jsonData);
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = await auth.clientViaServiceAccount(credentials, scopes);
      final String token = client.credentials.accessToken.data;
      client.close();
      return token;
    } catch (e) {
      log('❌ Error getting access token: $e');
      return null;
    }
  }
}
