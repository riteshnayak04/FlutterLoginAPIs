import 'package:flutter_registration_api/Services/shared_pref_service.dart';

class NetworkHandlerServie {}

class GetTokenService {
  static Future<String> getToken() async {
    return await SharedPrefService.getAccessToken();
  }

  static Map<String, String>? getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getToken()}' //
    };
  }
}
