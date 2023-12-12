import 'package:flutter/material.dart';
import 'package:flutter_registration_api/Models/otp_verification_model.dart';
import 'package:flutter_registration_api/Services/api_service.dart';

class OTPVerificationProvider with ChangeNotifier {
  ApiService apiService = ApiService();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  Future<void> otpVerification({
    required OTPVerificationModel otpVerificationModel,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    isLoading = true;
    notifyListeners();
    final response = await apiService.otpVerification(otpVerificationModel);
    isLoading = false;
    notifyListeners();
    if (response == true) {
      onSuccess();
    } else {
      onError('Failed to verify OTP!');
    }
  }
}
