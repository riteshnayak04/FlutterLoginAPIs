import 'dart:convert';
import 'dart:developer';
import 'package:flutter_registration_api/Models/otp_verification_model.dart';
import 'package:flutter_registration_api/Models/phone_number_verification_model.dart';
import 'package:flutter_registration_api/Services/network_handler_service.dart';
import 'package:flutter_registration_api/Services/shared_pref_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String?> phoneNumberVerification(
      PhoneNumberVerificationModel phoneNumberVerificationModel) async {
    const url = 'https://www.ondeindia.com/api/user/login';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(phoneNumberVerificationModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var userId = decodedResponse["data"][0]["id"];
      return userId.toString();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // OTP Verification

  Future<bool> otpVerification(
      OTPVerificationModel otpVerificationModel) async {
    const url = 'https://www.ondeindia.com/api/user/verify_otp';
    log(jsonEncode(otpVerificationModel
        .toJson())); // log is used to print the body in the console
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(otpVerificationModel.toJson()),
      headers: GetTokenService.getHeaders(),
    );
    log(response.statusCode
        .toString()); // log is used to print the status code in the console
    log(response.body); // log is used to print the body in the console
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      print('### 1. decodedResponse: $decodedResponse');
      // print access token
      print(
          '### 2. decodedResponse["access_token"]: ${decodedResponse["access_token"]}');
      log('### 2. decodedResponse["access_token"]: ${decodedResponse["access_token"]}');
      // set access token in shared preferences
      await SharedPrefService.saveAccessToken(
          decodedResponse["access_token"].toString());
      return true;
    } else {
      return false;
    }
  }
}



// class ApiService {
//   Future<String?> phoneNumberVerification(
//       PhoneNumberVerificationModel phoneNumberVerificationModel) async {
//     const url = 'https://www.ondeindia.com/api/user/login';
//     final response = await http.post(
//       Uri.parse(url),
//       body: jsonEncode(phoneNumberVerificationModel.toJson()),
//       headers: {'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200) {
//       final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
//       print('### 1. decodedResponse: $decodedResponse');

//       var userId = decodedResponse["data"][0]["id"];
//       // set user id in shared preferences
//       await SharedPrefService.saveId(userId);
//       print(
//           '### 2. decodedResponse["data"][0]["id"]: ${userId.runtimeType} $userId');
//       return userId.toString();
//     } else {
//       throw Exception('Failed to load data!');
//     }
//   }

//   // OTP Verification

//   Future<bool> otpVerification(
//       OTPVerificationModel otpVerificationModel) async {
//     const url = 'https://www.ondeindia.com/api/user/verify_otp';
//     log(jsonEncode(otpVerificationModel.toJson()));
//     final response = await http.post(
//       Uri.parse(url),
//       body: jsonEncode(otpVerificationModel.toJson()),
//       headers: {'Content-Type': 'application/json'},
//     );
//     log(response.statusCode.toString());
//     log(response.body);
//     if (response.statusCode == 200) {
//       final decodedResponse = jsonDecode(response.body);
//       print('### 1. decodedResponse: $decodedResponse');
//       // check user and otp id in shared preferences
//       // var userId = await SharedPrefService.getId();
//       // if (userId == otpVerificationModel.userId) {
//       //   print('### 1. userId: ${userId.runtimeType} $userId');
//       //   print('### 2. decodedResponse: $decodedResponse');
//       //   return true;
//       // } else {
//       //   throw Exception('Failed to load data!');
//       // }
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
